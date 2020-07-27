package com.celecavac.advent11;

import android.util.Log;

public class PowerBooster {
    String result;
    String result2;
    private static int HEIGHT = 300;
    private static int WIDTH = 300;
    private int array[][] = new int[HEIGHT][WIDTH];
    private int maximalMaxPower = Integer.MIN_VALUE;

    public PowerBooster(int input) {
        for (int i = 0; i < HEIGHT; i++)
            for (int j = 0; j < WIDTH; j++) {
                int x = j + 1;
                int y = i + 1;

                int rackID = x + 10;
                int powerLevel = rackID * y;
                powerLevel += input;
                powerLevel *= rackID;
                powerLevel /= 100;
                powerLevel %= 10;
                powerLevel -= 5;

                array[i][j] = powerLevel;
            }

        for (int i = 0; i < HEIGHT; i++)
            findTheBestCell(i);
    }

    private String findTheBestCell(int size) {
        int maxPower = Integer.MIN_VALUE;
        int maxPowerX = -1;
        int maxPowerY = -1;

        for (int i = 0; i < HEIGHT - size - 1; i++) {
            for (int j = 0; j < WIDTH - size - 1; j++) {
                int currentPower = 0;

                for (int iSub = i; iSub < i + size; iSub++) {
                    for (int jSub = j; jSub < j + size; jSub++) {
                        currentPower += array[iSub][jSub];
                    }
                }

                if (currentPower > maxPower) {
                    maxPower = currentPower;
                    maxPowerX = j + 1;
                    maxPowerY = i + 1;
                }
            }
        }

        String ret = maxPowerX + "," + maxPowerY;

        if (size == 3)
            result = ret;

        if (maximalMaxPower < maxPower) {
            maximalMaxPower = maxPower;
            result2 = ret + "," + size;
        }

        return ret;
    }

    public String getResult() {
        return result;
    }

    public String getResult2() {
        return result2;
    }
}
