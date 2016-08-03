package com.kingit.controller;

import com.kingit.dto.FlashMessage;
import com.kingit.utils.Md5Util;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class LoginController {
    @RequestMapping(value = "/",method = RequestMethod.GET)
    public String login(){
        return "login";
    }
    @RequestMapping(value = "/",method = RequestMethod.POST)
    public String login(String username, String password, RedirectAttributes redirectAttributes){
        Subject subject = SecurityUtils.getSubject();
        password = Md5Util.Md5(password);

        if (subject.isAuthenticated()){
            subject.logout();
        }
        try {
            UsernamePasswordToken token = new UsernamePasswordToken(username,password);
            subject.login(token);
            return "redirect:/home";
        } catch (LockedAccountException ex){
            redirectAttributes.addFlashAttribute("message",new FlashMessage(FlashMessage.STATE_ERROR,"账号已被禁用."));

        }catch (AuthenticationException e) {
            redirectAttributes.addFlashAttribute("message",new FlashMessage(FlashMessage.STATE_ERROR,"账号或密码错误."));
            redirectAttributes.addFlashAttribute("username",username);
        }
        return "redirect:/";
    }

    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public String logout(RedirectAttributes redirectAttributes){
        SecurityUtils.getSubject().logout();//登录退出机制
        redirectAttributes.addFlashAttribute("message",new FlashMessage(FlashMessage.STATE_SUCCESS,"退出成功."));
        return "redirect:/";
    }

    @RequestMapping(value = "/403")
    public String error403(){
        return "error/403";
    }

    @RequestMapping(value = "/home",method = RequestMethod.GET)
    public String home(){
        return "home";
    }

}
