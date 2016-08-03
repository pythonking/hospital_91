package com.kingit.service;

import com.kingit.dao.RoleDao;
import com.kingit.dao.UserDao;
import com.kingit.pojo.Role;
import com.kingit.pojo.User;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import javax.inject.Named;

/**
 * Created by Administrator on 2016/7/8.
 */
@Named
@Transactional
public class ShiroRealm extends AuthorizingRealm {
    @Inject
    private UserDao userDao;
    @Inject
    private RoleDao roleDao;

    /**
     * 验证是否具有某项权限
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        User user = (User) principalCollection.getPrimaryPrincipal();
        if (user != null){
            //根据用户的RoleID获取Role对象
            Role role = roleDao.findById(user.getRole().getId());
            //将用户的角色名称赋值给info
            SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
            info.addRole(role.getRolename());
            return info;
        }
        return null;
    }

    /**
     * 验证用户名和密码是否正确
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
        String username = token.getUsername();//获取用户表单中的账号
        User user = userDao.findByUserName(username);
        if (user != null){
            if (!user.getEnable()){
                throw new LockedAccountException("账号已被禁用");
            }
            return new SimpleAuthenticationInfo(user,user.getPassword(),getName());
        }else {
            throw new UnknownAccountException("账号或密码错误");
        }
    }
}
