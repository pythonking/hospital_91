package com.kingit.dao;

import com.kingit.pojo.User;
import org.hibernate.SQLQuery;

import javax.inject.Named;

@Named
public class UserDao extends BaseDao<User,Integer> {
    public User findByUserName(String username) {
        String sql = "select * from t_user where username = :useranme";
        SQLQuery query = getSession().createSQLQuery(sql).addEntity(User.class);//直接封装成想要对象
        query.setParameter("useranme",username);
        User user = (User) query.uniqueResult();
        return user;
    }
}
