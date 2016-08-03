package com.kingit.service;

import com.google.common.collect.Lists;
import com.kingit.dao.PatientDao;
import com.kingit.pojo.Patient;
import com.kingit.utils.Page;
import com.kingit.utils.SearchParam;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;
import java.util.Map;

@Named
@Transactional
public class PatientService {
    @Inject
    private PatientDao patientDao;

    public void saveOrUpdate(Patient patient){
        patientDao.save(patient);
    }

    public void delete(Integer id){
        patientDao.delete(id);
    }

    public Patient findById(Integer id){
        return patientDao.findById(id);
    }
    public Patient loadById(Integer id){
        return patientDao.loadById(id);
    }

    public List<Patient> findAll(){
        return patientDao.findAll();
    }

    public Page<Patient> fingByParam(Map<String ,Object> param){
        Integer pageNo =Integer.parseInt((String) param.get("start"));
        Integer pageSize = Integer.parseInt((String) param.get("length"));
        List<SearchParam> searchParamList = Lists.newArrayList();
        return patientDao.findByPageNo(pageNo,pageSize,searchParamList);
    }

    public Long count() {
        return patientDao.count();
    }
}
