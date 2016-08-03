package com.kingit.pojo;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "t_disease")
public class Disease implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String illnese;
    @ManyToOne
    @JoinColumn(name = "deptid")
    private Dept dept;

    public Disease() {
    }

    public Disease(String illnese) {
        this.illnese = illnese;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getIllness() {
        return illnese;
    }

    public void setIllness(String illnese) {
        this.illnese = illnese;
    }


    public Dept getDept() {
        return dept;
    }

    public void setDept(Dept dept) {
        this.dept = dept;
    }
}
