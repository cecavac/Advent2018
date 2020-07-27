package com.celecavac.advent1;

public class FrequencyCounter {
    private int frequency = 0;

    public FrequencyCounter(String frequencies) {
        String split[] = frequencies.split("\\n");

        for (String f : split) {
            frequency += Integer.parseInt(f);
        }
    }

    public String getFrequency() {
        return Integer.toString(frequency);
    }
}
