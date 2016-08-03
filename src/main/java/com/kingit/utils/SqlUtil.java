package com.kingit.utils;

import com.google.common.collect.Lists;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.util.Iterator;
import java.util.List;

/**
 * Created by Administrator on 2016/7/16.
 */
public class SqlUtil {

    public static String update(Object model) throws NoSuchMethodException, IllegalAccessException, InvocationTargetException {
        String saveStatement = "";
        String saveStatement2 = "";
        String saveStatement3 = "";

        List<String> set = getProperty(model);
        Iterator<String> it = set.iterator();
        while (it.hasNext()){
            saveStatement = it.next();
            if (saveStatement.equals("id")){
                continue;
            }
            saveStatement2 = "#{" + saveStatement + "}";
            saveStatement3 += saveStatement + "=" + saveStatement2 + ",";
        }

        saveStatement3 = saveStatement3.substring(0, saveStatement3.length() - 1);
        return "UPDATE  " + "t_xxx " + "SET " + saveStatement3 + " WHERE id=#{id}";
    }

    public static String setUpdate(Object model) throws NoSuchMethodException, IllegalAccessException, InvocationTargetException {
        String saveStatement = "";
        String saveStatement2 = "";
        String saveStatement3 = "";

        List<String> set = getProperty(model);
        Iterator<String> it = set.iterator();

        while (it.hasNext()){
            saveStatement = it.next();
            if (saveStatement.equals("id")){
                continue;
            }
            int i=0;
            saveStatement2 = "#{" + saveStatement + "}";

            if ( set.size()== 1) {
                saveStatement3 += "<if test =\" " + saveStatement + " !=null and " + saveStatement + "!=''\">" + " " + saveStatement + "=" + saveStatement2 + ",</if>";
            } else if (i < set.size() - 1) {
                saveStatement3 += "<if test =\" " + saveStatement + " !=null and " + saveStatement + "!=''\">" + saveStatement + "=" + saveStatement2 + ",</if>";
            } else {
                saveStatement3 += "<if test =\" " + saveStatement + " !=null and " + saveStatement + "!=''\">" + saveStatement + "=" + saveStatement2 + "</if>";
            }
            i++;
            if (i==set.size()-1){
                break;
            }
        }
        return "UPDATE  " + "t_xxx " + "<set> " + saveStatement3 + "</set> WHERE id=#{id}";
    }

    public static List<String> getProperty(Object model) throws NoSuchMethodException,
            IllegalAccessException, IllegalArgumentException,
            InvocationTargetException {
        List<String> stringList = Lists.newArrayList();
        // 获取实体类的所有属性，返回Field数组
        Field[] field = model.getClass().getDeclaredFields();
        // 遍历所有属性
        for (int j = 0; j < field.length; j++) {
            // 获取属性的名字
            String propertyName = field[j].getName();
            stringList.add(propertyName);
        }
        return stringList;
    }

    public static String getInsertSql(Object model) throws NoSuchMethodException, IllegalAccessException, InvocationTargetException {
        List<String> set = getProperty(model);
        Iterator<String> it = set.iterator();
        String saveStatement = "";
        String saveStatement2 = "";
        String name = "";
        while (it.hasNext()) {
            name = it.next();
            saveStatement += name + ",";
            saveStatement2 += "#{" + name + "},";
        }
        saveStatement = saveStatement.substring(0, saveStatement.length() - 1);
        saveStatement2 = saveStatement2.substring(0, saveStatement2.length() - 1);
        return "INSERT INTO  " + "t_xxx" + "(" + saveStatement + ")" + "  VALUES(" + saveStatement2 + ")";
    }
}
