package com.kingit.pojo;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "t_user")
public class User implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String username;
    private String realname;
    private String telphone;
    private String password;
    private String creattime;
    @ManyToOne
    @JoinColumn(name = "deptid")
    private Dept Dept;
    private Boolean enable;
    @ManyToOne
    @JoinColumn(name = "roleid")
    private Role role;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public String getTelphone() {
        return telphone;
    }

    public void setTelphone(String telphone) {
        this.telphone = telphone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCreattime() {
        return creattime;
    }

    public void setCreattime(String creattime) {
        this.creattime = creattime;
    }

    public com.kingit.pojo.Dept getDept() {
        return Dept;
    }

    public void setDept(com.kingit.pojo.Dept dept) {
        Dept = dept;
    }

    public Boolean getEnable() {
        return enable;
    }

    public void setEnable(Boolean enable) {
        this.enable = enable;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", realname='" + realname + '\'' +
                ", telphone='" + telphone + '\'' +
                ", password='" + password + '\'' +
                ", creattime='" + creattime + '\'' +
                ", Dept=" + Dept +
                ", enable=" + enable +
                ", role=" + role +
                '}';
    }
}
