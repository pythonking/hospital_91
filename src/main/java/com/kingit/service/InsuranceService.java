package com.kingit.service;

import com.kingit.dao.InsuranceDao;
import com.kingit.pojo.Insurance;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;

@Named
@Transactional
public class InsuranceService {
    @Inject
    private InsuranceDao insuranceDao;
    public void save(Insurance insurance){
        insuranceDao.save(insurance);
    }

    public Insurance findById(Integer id){
        return insuranceDao.findById(id);
    }

    public List<Insurance> findAll(){
        return insuranceDao.findAll();
    }

    public void delete(Integer id) {
        insuranceDao.delete(id);
    }

    public void update(Insurance insurance) {
        insuranceDao.update(insurance);
    }

}
