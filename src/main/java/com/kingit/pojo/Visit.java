package com.kingit.pojo;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;

@Entity
@Table(name = "t_visit")
public class Visit implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String chubuzhenduan;
    private String zhengzhuang;
    private String bingshi;
    private String yangxingtezheng;
    private String jianchajieguo;
    private String zhiliaofangan;
    private String beddoctor;
    private Timestamp nexttime;
    private Timestamp creattime;
    @ManyToOne
    @JoinColumn(name = "patientid")
    private Patient patient;
    @ManyToOne
    @JoinColumn(name = "deptid")
    private Dept dept;
    @ManyToOne
    @JoinColumn(name = "diseaseid")
    private Disease disease;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getChubuzhenduan() {
        return chubuzhenduan;
    }

    public void setChubuzhenduan(String chubuzhenduan) {
        this.chubuzhenduan = chubuzhenduan;
    }

    public String getZhengzhuang() {
        return zhengzhuang;
    }

    public void setZhengzhuang(String zhengzhuang) {
        this.zhengzhuang = zhengzhuang;
    }

    public String getBingshi() {
        return bingshi;
    }

    public void setBingshi(String bingshi) {
        this.bingshi = bingshi;
    }

    public String getYangxingtezheng() {
        return yangxingtezheng;
    }

    public void setYangxingtezheng(String yangxingtezheng) {
        this.yangxingtezheng = yangxingtezheng;
    }

    public String getJianchajieguo() {
        return jianchajieguo;
    }

    public void setJianchajieguo(String jianchajieguo) {
        this.jianchajieguo = jianchajieguo;
    }

    public String getZhiliaofangan() {
        return zhiliaofangan;
    }

    public void setZhiliaofangan(String zhiliaofangan) {
        this.zhiliaofangan = zhiliaofangan;
    }

    public String getBeddoctor() {
        return beddoctor;
    }

    public void setBeddoctor(String beddoctor) {
        this.beddoctor = beddoctor;
    }

    public Timestamp getNexttime() {
        return nexttime;
    }

    public void setNexttime(Timestamp nexttime) {
        this.nexttime = nexttime;
    }

    public Timestamp getCreattime() {
        return creattime;
    }

    public void setCreattime(Timestamp creattime) {
        this.creattime = creattime;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public Dept getDept() {
        return dept;
    }

    public void setDept(Dept dept) {
        this.dept = dept;
    }

    public Disease getDisease() {
        return disease;
    }

    public void setDisease(Disease disease) {
        this.disease = disease;
    }
}
