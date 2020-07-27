package com.celecavac.advent2;

import java.util.Arrays;

public class IdLetterCounter {
    private int result;

    public IdLetterCounter(String frequencies) {
        String split[] = frequencies.split("\\n");
        int []letterJournal = new int['z' - 'a' + 1];
        int twoLettersCounter = 0;
        int threeLettersCounter = 0;

        for (String id : split) {
            Arrays.fill(letterJournal, 0);
            for (char c : id.toCharArray()) {
                letterJournal[c - 'a']++;
            }

            boolean increment2LC = false;
            boolean increment3LC = false;
            for (int i : letterJournal) {
                if (i == 2)
                    increment2LC = true;

                if (i == 3)
                    increment3LC = true;
            }

            if (increment2LC)
                twoLettersCounter++;

            if (increment3LC)
                threeLettersCounter++;
        }

        result = twoLettersCounter * threeLettersCounter;
    }

    public String getResult() {
        return Integer.toString(result);
    }
}
