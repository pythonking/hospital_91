package com.kingit.pojo;

/**
 * Created by Administrator on 2016/7/31.
 */
public class PatientState {
    public static final String STATE_ONLINE="在诊";
    public static final String STATE_UPLINE="急诊";
    public static final String STATE_OFFLINE="出院";

    private Integer id;
    private String state;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}
