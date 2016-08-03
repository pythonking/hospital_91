package com.kingit.dao;

import com.kingit.utils.Page;
import com.kingit.utils.SearchParam;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.*;
import org.hibernate.transform.ResultTransformer;

import javax.inject.Inject;
import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.List;

public class BaseDao<T, PK extends Serializable> {

    @Inject
    private SessionFactory sessionFactory;

    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    private Class<?> entityClass;

    public BaseDao() {
        //读取子类的泛型参数,parameterizedType.getActualTypeArguments()获取实际的泛型数组
        ParameterizedType parameterizedType = (ParameterizedType) this.getClass().getGenericSuperclass();
        entityClass = (Class<?>) parameterizedType.getActualTypeArguments()[0];
    }

    public void save(T entity) {
        getSession().saveOrUpdate(entity);
    }

    public void delete(PK id) {
        getSession().delete(findById(id));
    }

    public void update(T entity) {
        getSession().saveOrUpdate(entity);
    }

    public T findById(PK id) {
        return (T) getSession().get(entityClass, id);
    }
    public T loadById(PK id) {
        return (T) getSession().load(entityClass, id);
    }

    public List<T> findAll() {
        Criteria criteria = getSession().createCriteria(entityClass);
        criteria.addOrder(Order.desc("id"));
        List<T> tList = criteria.list();
        return tList;
    }

    public Long count() {
        Criteria criteria = getSession().createCriteria(entityClass);
        criteria.setProjection(Projections.rowCount());
        Long count = (Long) criteria.uniqueResult();
        return count;
    }

    public Long count(Criteria criteria) {
        ResultTransformer resultTransformer = criteria.ROOT_ENTITY;//记录原始数据

        criteria.setProjection(Projections.rowCount());
        Long count = (Long) criteria.uniqueResult();

        criteria.setProjection(null);//清空数据
        criteria.setResultTransformer(resultTransformer);//还原数据

        return count;
    }

    /**
     * 无搜索功能的分页系统
     *
     * @param pageNo
     * @param pageSize
     * @return
     */
    public Page<T> findByPageNo(Integer pageNo, Integer pageSize) {
        Integer totalSize = count().intValue();
        Criteria criteria = getSession().createCriteria(entityClass);
        Page<T> page = new Page<>(pageNo, pageSize, totalSize);
        criteria.setFirstResult(page.getStart());
        criteria.setMaxResults(pageSize);
        List<T> result = criteria.list();
        page.setItems(result);

        return page;
    }

    /**
     * 有搜索功能的分页系统
     *
     * @param pageNo
     * @param pageSize
     * @return
     */
    public Page<T> findByPageNo(Integer pageNo, Integer pageSize, List<SearchParam> searchParamList) {
        Criteria criteria = buildCriteriaBySearchParam(searchParamList);
        Integer totalSize = count(criteria).intValue();
        Page<T> page = new Page<>(pageNo, pageSize, totalSize);
        criteria.setFirstResult(page.getStart());
        criteria.setMaxResults(pageSize);
        List<T> result = criteria.list();
        page.setItems(result);

        return page;
    }

    private Criteria buildCriteriaBySearchParam(List<SearchParam> searchParamList) {
        Criteria criteria = getSession().createCriteria(entityClass);
        for (SearchParam searchParam : searchParamList) {
            String propertyName = searchParam.getPropertyName();
            String type = searchParam.getType();
            Object value = searchParam.getValue();

            if (propertyName.contains("_or_")) {
                String[] names = propertyName.split("_or_");
                Disjunction disjunction = Restrictions.disjunction();//多重条件判断判断
                for (String name : names) {
                    Criterion criterion = buildCrition(name, type, value);
                    disjunction.add(criterion);
                }
                criteria.add(disjunction);
            } else {
                Criterion criterion = buildCrition(propertyName, type, value);
                criteria.add(criterion);
            }
        }
        return criteria;
    }

    public Criterion buildCrition(String propertyName, String type, Object value) {
        if("eq".equalsIgnoreCase(type)) {
            return Restrictions.eq(propertyName,value).ignoreCase();
        } else if("like".equalsIgnoreCase(type)) {
            return Restrictions.like(propertyName,value.toString(), MatchMode.ANYWHERE).ignoreCase();
        } else if("ge".equalsIgnoreCase(type)) {
            return Restrictions.ge(propertyName,value);
        } else if("gt".equalsIgnoreCase(type)) {
            return Restrictions.gt(propertyName,value);
        } else if("le".equalsIgnoreCase(type)) {
            return Restrictions.le(propertyName,value);
        } else if("lt".equalsIgnoreCase(type)) {
            return Restrictions.lt(propertyName,value);
        }
        return null;
    }
}
