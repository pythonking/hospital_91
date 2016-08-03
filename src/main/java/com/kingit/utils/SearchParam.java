package com.kingit.utils;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/7/28.
 */
public class SearchParam {
    private String type;
    private String propertyName;
    private Object value;

    public static Map<String, String> getQueryMap(HttpServletRequest request) {
        Map<String, String> queryMap = Maps.newHashMap();
        Enumeration<String> enumeration = request.getParameterNames();
        while (enumeration.hasMoreElements()) {
            String key = enumeration.nextElement();
            String valueType = key.split("_",4)[2];
            Object value = request.getParameter(key);
            value = valueSwitch(valueType,value);
        }
        return queryMap;
    }

    public static List<SearchParam> buildSearchParam(HttpServletRequest request) {
        List<SearchParam> searchParamList = Lists.newArrayList();
        //获取查询的所有字符串
        Enumeration<String> enumeration = request.getParameterNames();
        while (enumeration.hasMoreElements()) {
            String queryString = enumeration.nextElement();//查询条件
            Object value = request.getParameter(queryString);
            if (queryString.startsWith("q_") && value != null && StringUtils.isNotEmpty(value.toString())){
                String[] array = queryString.split("_", 4);//把字符串分成四份,最后一个可能比较多
                if (array.length != 4) {
                    throw new RuntimeException("地址栏查询方式错误"+queryString);
                }
                String valueType = array[1];
                String type = array[2];
                String propertyName = array[3];

                SearchParam searchParam = new SearchParam();
                searchParam.setType(type);
                searchParam.setValue(valueSwitch(valueType,value));
                searchParam.setPropertyName(propertyName);

                searchParamList.add(searchParam);
            }
        }
        return searchParamList;
    }

    private static Object valueSwitch(String valueType, Object value) {
//        switch (valueType.toLowerCase()) {
//            case "s":
//                return Strings.toUTF8(value.toString());
//            case "f":
//                return Float.valueOf(value.toString());
//            case "d":
//                return Double.valueOf(value.toString());
//            case "i":
//                return Integer.valueOf(value.toString());
//            case "b":
//                return Boolean.valueOf(value.toString());
//        }
        if("s".equalsIgnoreCase(valueType)) {
            return Strings.toUTF8(value.toString());
        } else if("d".equalsIgnoreCase(valueType)) {
            return Double.valueOf(value.toString());
        } else if("f".equalsIgnoreCase(valueType)) {
            return Float.valueOf(value.toString());
        } else if("b".equalsIgnoreCase(valueType)) {
            return Boolean.valueOf(value.toString());
        } else if("i".equalsIgnoreCase(valueType)) {
            return Integer.valueOf(value.toString());
        }
        return null;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getPropertyName() {
        return propertyName;
    }

    public void setPropertyName(String propertyName) {
        this.propertyName = propertyName;
    }

    public Object getValue() {
        return value;
    }

    public void setValue(Object value) {
        this.value = value;
    }
}
