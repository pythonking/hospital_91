package com.kingit.pojo;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "t_patient")
public class Patient implements Serializable {
    public static final String SEX_MAN="男";
    public static final String SEX_WOMAN="女";
    public static final String STATE_ONLINE="在诊";
    public static final String STATE_UPLINE="急诊";
    public static final String STATE_OFFLINE="已出院";
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String sex;
    private String idcard;
    private Integer age;
    private String telphone;
    private String address;
    private String guominshi;
    private String remark;
    private String state;
    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @ManyToOne
    @JoinColumn(name = "insuranceid")
    private Insurance insurance;
    private String creattime;

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public Patient() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getTelphone() {
        return telphone;
    }

    public void setTelphone(String telphone) {
        this.telphone = telphone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getGuominshi() {
        return guominshi;
    }

    public void setGuominshi(String guominshi) {
        this.guominshi = guominshi;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Insurance getInsurance() {
        return insurance;
    }

    public void setInsurance(Insurance insurance) {
        this.insurance = insurance;
    }

    public String getCreattime() {
        return creattime;
    }

    public void setCreattime(String creattime) {
        this.creattime = creattime;
    }
}
