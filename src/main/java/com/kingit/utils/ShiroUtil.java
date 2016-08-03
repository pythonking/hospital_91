package com.kingit.utils;

import com.kingit.pojo.User;
import org.apache.shiro.SecurityUtils;

public class ShiroUtil {
    public static User getCurrentUser() {
        //获取当前捕获对象
        User user = (User) SecurityUtils.getSubject().getPrincipal();
        return user;
    }

    public static Integer getCurrentUserId() {
        return getCurrentUser().getId();
    }

    public static String getCurrentUserName() {
        return getCurrentUser().getUsername();
    }

    public static String getCurrentRealName() {
        return getCurrentUser().getRealname();
    }

    public static boolean isDirector() {
        System.out.println(getCurrentUser());
        return "主任".equals(getCurrentUser().getRole().getRolename());
    }

    public static boolean isUser() {
        return "员工".equals(getCurrentUser().getRole().getRolename());
    }

    public static boolean isAdmin() {
        return "管理员".equals(getCurrentUser().getRole().getRolename());
    }
}
