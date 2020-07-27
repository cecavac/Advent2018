package com.celecavac.advent1;

import java.util.HashMap;

public class FrequencyRepeater {
    private int frequency = 0;
    private HashMap<Integer,Integer> map = new HashMap<Integer,Integer>();

    public FrequencyRepeater(String frequencies) {
        String split[] = frequencies.split("\\n");

        outer: while (true) {
            for (String f : split) {
                map.put(frequency, 0);

                frequency += Integer.parseInt(f);

                if (map.containsKey(frequency)) {
                    break outer;
                }
            }
        }
    }

    public String getFrequency() {
        return Integer.toString(frequency);
    }
}