package com.kingit.service;

import com.kingit.dao.VisitDao;
import com.kingit.pojo.Visit;
import com.kingit.utils.Page;
import com.kingit.utils.SearchParam;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;

@Named
@Transactional
public class VisitService {
    @Inject
    private VisitDao visitDao;
    @Inject
    private DocumentService documentService;

    public void saveOrUpdate(Visit visit) {
        visitDao.save(visit);
    }

    public void delete(Integer id) {
        visitDao.findById(id);
    }

    public Visit findById(Integer id) {
        return visitDao.findById(id);
    }

    public List<Visit> findAll() {
        return visitDao.findAll();
    }

    public Page<Visit> findBySearchParam(Integer pageNo, List<SearchParam> searchParamList) {
        return visitDao.findByPageNo(pageNo, 5, searchParamList);

    }

}
