package com.kingit.service;

import com.google.common.collect.Lists;
import com.kingit.dao.DiseaseDao;
import com.kingit.pojo.Disease;
import com.kingit.utils.Page;
import com.kingit.utils.SearchParam;
import org.apache.commons.lang3.StringUtils;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;

@Named
@Transactional
public class DiseaseService {
    @Inject
    private DiseaseDao diseaseDao;

    public void save(Disease disease) {
        diseaseDao.save(disease);
    }

    public void delete(Integer id) {
        diseaseDao.delete(id);
    }

    public void update(Disease disease) {
        diseaseDao.update(disease);
    }

    public Disease findById(Integer id) {
        return diseaseDao.findById(id);
    }

    public List<Disease> findAll() {
        return diseaseDao.findAll();
    }

    public Long count() {
        return diseaseDao.count();
    }

    public Page<Disease> findByPageNo(String start, String length, String keyWord) {
        Integer pageNo = Integer.parseInt(start);
        Integer pageSize = Integer.parseInt(length);
        SearchParam searchParam = new SearchParam();
        searchParam.setType("like");
        searchParam.setPropertyName("illnese_or_deptname");
        searchParam.setValue(keyWord);
        List<SearchParam> searchParamList = Lists.newArrayList();
        if (keyWord != null && StringUtils.isNotEmpty(keyWord.toString())) {
            searchParamList.add(searchParam);
        }
        return diseaseDao.findByPageNo(pageNo, pageSize, searchParamList);
    }
}
