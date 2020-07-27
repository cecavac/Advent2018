package com.celecavac.advent4;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public class GuardWatcher {
    private int [][]patch = new int[1000][1000];
    private int result = 0;
    private int result2 = 0;
    private HashMap<Integer, ArrayList<GuardEntry>> map =
            new HashMap<Integer, ArrayList<GuardEntry>>();

    public GuardWatcher(String input) {
        fillMap(input);
        findSleepyHead();
    }

    private void fillMap(String input) {
        String split[] = input.split("\\n");
        ArrayList<GuardEntry> guardEntryList = new ArrayList<GuardEntry>();
        int id = -1;

        for (String entry : split) {
            String entrySplit[] = entry.split(" ");

            String date = entrySplit[0];
            int year = Integer.parseInt(date.substring(1,5));
            int month = Integer.parseInt(date.substring(6,8));
            int day = Integer.parseInt(date.substring(9,11));


            String time = entrySplit[1];
            int hour = Integer.parseInt(time.substring(0,2));
            int minute = Integer.parseInt(time.substring(3,5));
            String formatedDate = year + "/";
            if (month < 10)
                formatedDate += 0;
            formatedDate += month + "/";
            if (day < 10)
                formatedDate += 0;
            formatedDate += day;

            String description = entrySplit[2];
            GuardEntry guardEntry = null;
            GuardEntry.Action action;
            if (description.equals("wakes") || description.equals("falls")) {
                if (description.equals("wakes")) {
                    action = GuardEntry.Action.WAKE;
                } else {
                    action = GuardEntry.Action.SLEEP;
                }

                guardEntry = new GuardEntry(formatedDate, hour, minute, action);
            } else {
                //action = GuardEntry.Action.START_SHIFT;
                id = Integer.parseInt(entrySplit[3].substring(1));
                guardEntry = new GuardEntry(id, formatedDate, hour, minute);
            }

            guardEntryList.add(guardEntry);
        }

        Collections.sort(guardEntryList);
        for (GuardEntry guardEntry : guardEntryList) {
            if (guardEntry.getId() != -1)
                id = guardEntry.getId();

            if(!map.containsKey(id))
                map.put(id, new ArrayList<GuardEntry>());

            map.get(id).add(guardEntry);
        }

    }

    private void findSleepyHead() {
        int []maxSleepArray = null;
        int maxTime = 0;
        int id = -1;

        int maxSameMinute = 0;

        GuardEntry previousGuardEntry = null;

        for (Map.Entry<Integer, ArrayList<GuardEntry>> entry : map.entrySet()) {
            int timeSlept = 0;
            int []sleepArray = new int[60];

            for (GuardEntry guardEntry : entry.getValue()) {
                if (guardEntry.getId() != -1) {
                    previousGuardEntry = null;
                    continue;
                }

                if (previousGuardEntry == null) {
                    previousGuardEntry = guardEntry;
                    continue;
                }

                timeSlept += guardEntry.getMinute() - previousGuardEntry.getMinute();
                for (int i = previousGuardEntry.getMinute(); i < guardEntry.getMinute(); i++)
                    sleepArray[i]++;

                previousGuardEntry = null;
            }

            if (maxTime < timeSlept) {
                maxTime = timeSlept;
                id = entry.getKey();
                maxSleepArray = sleepArray;
            }

            String s = entry.getKey() +": ";
            for (int i = 0; i < 60; i++) {
                s = s + "|" + i + ":" + sleepArray[i];
                if (sleepArray[i] > maxSameMinute) {
                    maxSameMinute = sleepArray[i];
                    result2 =  entry.getKey() * i;
                }
            }

        }

        int maxMin = 0;
        for (int i = 0; i < 60; i++) {
            if (maxSleepArray[i] > maxMin) {
                maxMin = maxSleepArray[i];
                result = id * i;
            }
        }
    }

    public String getResult() {
        return Integer.toString(result);
    }

    public String getResult2() {
        return Integer.toString(result2);
    }
}
