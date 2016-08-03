package com.kingit.pojo;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "t_insurance")
public class Insurance implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String type;

    public Integer getId() {
        return id;
    }

    public Insurance() {
    }

    public Insurance(String type) {
        this.type = type;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
