package com.celecavac.advent12;

import android.util.Log;

public class Potter {
    private long result = 0;
    private int arrayGrowth = 3;
    private long totalGrowth = 0;
    private static boolean DEBUG = false;
    private long diff;
    private long iterations;

    public Potter(String input, long iterations) {
        this.iterations = iterations;
        String split[] = input.split("\\n");
        String splitFirst[] = split[0].split(" ");
        char initialArray[] = splitFirst[2].toCharArray();

        char rules[] = new char[32];
        for (int i = 0; i < split.length - 2; i++) {
            char rule[] = split[i + 2].toCharArray();
            int index = ruleToInt(rule, 0);
            rules[index] = rule[rule.length - 1];
        }

        for (int i = 0; i < 32; i++) {
            /* Initialize omitted rules */
            if (rules[i] != '.' && rules[i] != '#')
                rules[i] = '.';
            if (DEBUG)
                Log.e("RULES", "i: " + i + " " + rules[i]);
        }

        printArray(initialArray);

        for (long i = 0; i < iterations; i++) {
            boolean skipGrowth = true;
            int currentGrowth = 0;

            for (int j = 0; j < 5; j++) {
                if (initialArray[j] == '#' || initialArray [initialArray.length -1 - j] == '#') {
                    skipGrowth = false;
                    currentGrowth = arrayGrowth;
                    break;
                }
            }

            totalGrowth += currentGrowth;

            char workingArray[] = new char[currentGrowth + initialArray.length + currentGrowth];
            char expandedArray[];

            if (!skipGrowth) {
                expandedArray = new char[currentGrowth + initialArray.length + currentGrowth];

                for (int j = 0; j < arrayGrowth; j++) {
                    expandedArray[j] = '.';
                    expandedArray[expandedArray.length - 1 - j] = '.';
                }

                for (int j = 0; j < initialArray.length; j++)
                    expandedArray[j + currentGrowth] = initialArray[j];
            } else {
                expandedArray = initialArray;
            }

            for (int j = 0; j < 2; j++) {
                workingArray[j] = '.';
                workingArray[workingArray.length - 1 - j] = '.';
            }

            for (int j = 0; j < expandedArray.length - 4; j++) {
                int index = ruleToInt(expandedArray, j);
                workingArray[j + 2] = rules[index];
            }

            initialArray = workingArray;
            printArray(initialArray);

            long oldResult = result;
            result = 0;
            for (int j = 0; j < initialArray.length; j++) {
                if (initialArray[j] == '#') {
                    long position = j - totalGrowth;
                    result += position;
                }
            }

            diff = result - oldResult;
        }
    }

    private int ruleToInt(char c[], int offset) {
        int ret = 0;

        for (int i = 0; i < 5; i++) {
            ret = ret << 1;
            if (c[i + offset] == '#')
                ret++;
        }

        return ret;
    }

    private void printArray(char array[]) {
        if (!DEBUG)
            return;

        StringBuilder builder = new StringBuilder();
         builder.append(array);
        Log.e("ARRAY", builder.toString());
    }

    public void completeLongIterationCycle(long totalIterations) {
        totalIterations -= iterations;
        result += totalIterations * diff;

        Log.e("Copy me", getResult());
    }

    public String getResult() {
        return Long.toString(result);
    }
}
