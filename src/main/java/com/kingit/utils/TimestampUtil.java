package com.kingit.utils;




import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Administrator on 2016/8/2.
 */
public class TimestampUtil {
    public static Timestamp stringToTimestamp(String timeString){
        return Timestamp.valueOf(timeString);
    }

    public static String timestampTOyyMMdd(Timestamp timestamp){
        SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd hh:mm:ss");
        return sdf.format(timestamp);
    }

    public static Timestamp getNowTimestamp(){
        Date date = new Date();
        return new Timestamp(date.getTime());
    }
}
