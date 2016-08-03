package com.kingit.service;

import com.kingit.dao.DeptDao;
import com.kingit.pojo.Dept;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;

@Named
@Transactional
public class DeptService {
    @Inject
    private DeptDao deptDao;

    public void save(Dept dept){
        deptDao.save(dept);
    }
    public void delete(Integer id){
        deptDao.delete(id);
    }

    public void update(Dept dept){
        deptDao.update(dept);
    }

    public Dept findById(Integer id){
        return deptDao.findById(id);
    }

    public List<Dept> findAll(){
        return deptDao.findAll();
    }
}
