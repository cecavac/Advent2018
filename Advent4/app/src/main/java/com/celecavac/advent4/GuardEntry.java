package com.celecavac.advent4;

import android.support.annotation.NonNull;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class GuardEntry implements Comparable {
    public enum Action {
        START_SHIFT,
        SLEEP,
        WAKE
    }

    private int id = -1;
    private String date;
    private int hour;
    private int minute;
    private Action action;

    public GuardEntry(int id, String date, int hour, int minute) {
        this(date, hour, minute, Action.START_SHIFT);
        this.id = id;
    }

    public GuardEntry(String date, int hour, int minute, Action action) {
        this.date = date;
        this.hour = hour;
        this.minute = minute;
        this.action = action;
    }

    public int getId() {
        return id;
    }

    public int getMinute() {
        return minute;
    }

    @Override
    public int compareTo(@NonNull Object o) {
        GuardEntry other = (GuardEntry) o;
        int ret;

        ret = date.compareTo(other.date);
        if (ret != 0)
            return ret;

        ret = hour - other.hour;
        if (ret != 0)
            return ret;

        return minute - other.minute;
    }

    public static String getNextDate(String  curDate) {
        final SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/DD");
        final Date date;
        String ret = null;

        try {
            date = format.parse(curDate);
            final Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);
            calendar.add(Calendar.DAY_OF_YEAR, 1);
            ret = format.format(calendar.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return ret;
    }
}
