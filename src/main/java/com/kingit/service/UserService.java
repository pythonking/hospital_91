package com.kingit.service;

import com.kingit.dao.UserDao;
import com.kingit.pojo.User;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;

@Named
@Transactional
public class UserService {
    @Inject
    private UserDao userDao;
    public void save(User user){
        userDao.save(user);
    }
    public void delete(Integer id){
        userDao.delete(id);
    }

    public void update(User user){
        userDao.update(user);
    }

    public User findById(Integer id){
        return userDao.findById(id);
    }

    public List<User> findAll(){
        return userDao.findAll();
    }

    public User findByUserName(String username) {
        return userDao.findByUserName(username);
    }
}
