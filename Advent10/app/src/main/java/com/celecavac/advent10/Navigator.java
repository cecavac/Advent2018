package com.celecavac.advent10;

import android.util.Log;

public class Navigator {
    private String result;

    Entry array[];


    public Navigator(String input) {
        String split[] = input.split("\\n");
        array = new Entry[split.length];


        for (int i = 0; i < split.length; i++) {
            String data = split[i];
            data = data.replace("< ", "<");
            data = data.replace("  ", " ");
            String lineSplit[] = data.split(" ");

            String temp = lineSplit[0].substring(10, lineSplit[0].length() -1);
            int x = Integer.parseInt(temp);

            temp = lineSplit[1].substring(0, lineSplit[1].length() -1);
            int y = Integer.parseInt(temp);

            temp = lineSplit[2].substring(10, lineSplit[2].length() -1);
            int vX = Integer.parseInt(temp);

            temp = lineSplit[3].substring(0, lineSplit[3].length() -1);
            int vY = Integer.parseInt(temp);

            array[i] = new Entry(x, y, vX, vY);
        }
    }

    public void printSolutionCandidates() {
        int width = 250;
        int height = 250;
        char matrix[][] = new char[height][width];
        int z = 0;

        boolean print = false;
        while (true) {
            z++;
            for (int i = 0; i < height; i++)
                for (int j = 0; j < width; j++)
                    matrix[i][j] = '.';

            for (Entry entry : array) {
                int x = entry.getX();
                int y = entry.getY();
                if (x >= 0 && x < width && y >=0 && y < height)
                    matrix[entry.getY()][entry.getX()] = '#';
                entry.tick();
            }

            boolean newPrint;
            if (Math.abs(array[0].getY() - array[array.length - 1].getY()) <= 20) {
                newPrint = true;
            } else {
                newPrint = false;
            }

            if (print == true && newPrint == false)
                break;
            print = newPrint;

            if (print == false)
                continue;

            for(int i = 0; i < 100; i++)
                if (matrix[0][i] == '#')
                    print = true;

            if (!print)
                continue;

            for (int i = 0; i < height; i++) {
                StringBuilder row = new StringBuilder();
                for (int j = 0; j < width; j++)
                    row.append(matrix[i][j]);
                Log.e("", row.toString());
            }
            Log.e("Seconds", Integer.toString(z));
        }
    }

    public String getResult() {
        return result;
    }
}
