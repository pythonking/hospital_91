package com.kingit.controller;

import com.kingit.pojo.Dept;
import com.kingit.pojo.User;
import com.kingit.service.DeptService;
import com.kingit.service.RoleService;
import com.kingit.service.UserService;
import com.kingit.utils.Md5Util;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Inject
    private UserService userService;
    @Inject
    private RoleService roleService;
    @Inject
    private DeptService deptService;

    @RequestMapping(value = "/userlist", method = RequestMethod.GET)
    public String userList(Model model) {
        List<User> userList = userService.findAll();
        List<Dept> deptList = deptService.findAll();
        model.addAttribute("userList", userList);
        model.addAttribute("deptList", deptList);
        return "user/list";
    }
    @RequestMapping(value = "/userlist", method = RequestMethod.POST)
    public String newUser(User user) {
        if (user.getPassword()==null){
            user.setPassword("000000");
        }
        user.setPassword(Md5Util.Md5(user.getPassword()));
        user.setEnable(true);
        userService.save(user);
        return "redirect:/admin/userlist";
    }

    @RequestMapping(value = "/resetpwd/{id:\\d+}")
    @ResponseBody
    public String resetPwd(@PathVariable("id") Integer id) {
        User user = userService.findById(id);
        user.setPassword(Md5Util.Md5("000000"));//密码重置为000000
        userService.update(user);
        return "success";
    }

    @RequestMapping(value = "/forbid/{id:\\d+}")
    @ResponseBody
    public String forbitUser(@PathVariable("id") Integer id) {
        User user = userService.findById(id);
        if (user.getEnable()){
            user.setEnable(false);
            userService.update(user);
            return "disable";
        }else {
            user.setEnable(true);
            userService.update(user);
            return "enable";
        }
    }
    @RequestMapping(value = "/user/{id:\\d+}")
    public String editUser(@PathVariable("id") Integer id,Model model){
        User user = userService.findById(id);
        model.addAttribute("usre",user);
        model.addAttribute("deptList", deptService.findAll());
        return "user/edit";
    }
}
