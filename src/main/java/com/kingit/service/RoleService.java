package com.kingit.service;

import com.kingit.dao.RoleDao;
import com.kingit.pojo.Role;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;

@Named
@Transactional
public class RoleService {
    @Inject
    private RoleDao roleDao;

    public void save(Role role){
        roleDao.save(role);
    }
    public void delete(Integer id){
        roleDao.delete(id);
    }

    public void update(Role role){
        roleDao.update(role);
    }

    public Role findById(Integer id){
        return roleDao.findById(id);
    }

    public List<Role> findAll(){
        return roleDao.findAll();
    }
}
