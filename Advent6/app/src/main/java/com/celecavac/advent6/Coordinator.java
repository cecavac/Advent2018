package com.celecavac.advent6;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class Coordinator {
    private static int width = 550;
    private static int hight = 550;
    private static int limit = 10000;

    private int [][]array = new int[width][hight];
    private HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
    private int result = 0;
    private int result2 = 0;
    private ArrayList<Coordinate> list = new ArrayList<Coordinate>();

    public Coordinator(String input) {
        String split[] = input.split("\\n");

        for (String entry : split) {
            list.add(new Coordinate(entry));
        }

        for (int i = 0; i < width; i++) {
            for (int j = 0; j < hight; j++) {
                Coordinate c = new Coordinate(i, j);
                boolean inBetween = false;
                int min = Integer.MAX_VALUE;
                int minIndex = -1;

                for (Coordinate coordinate : list) {
                    int distance = coordinate.distance(c);

                    if (distance == min) {
                        inBetween = true;
                        minIndex = -1;
                    }

                    if (distance < min) {
                        min = distance;
                        minIndex = list.indexOf(coordinate);
                        inBetween = false;
                    }
                }

                array[i][j] = minIndex;

                if (!inBetween) {
                    if (!map.containsKey(minIndex)) {
                        map.put(minIndex, 1);
                    } else {
                        int size = map.get(minIndex);
                        map.put(minIndex, size + 1);
                    }
                }
            }
        }

        /* Remove infinite fields */
        for (int i = 0; i < hight; i++) {
            map.remove(array[i][0]);
            map.remove(array[i][width - 1]);
        }
        for (int j = 0; j < width; j++) {
            map.remove(array[0][j]);
            map.remove(array[hight - 1][j]);
        }

        int max = 0;
        for (Map.Entry<Integer, Integer> entry : map.entrySet())
        {
            if (max < entry.getValue())
                max = entry.getValue();
        }
        result = max;


        secondRun();
    }

    public void secondRun() {
        for (int i = 0; i < width; i++) {
            for (int j = 0; j < hight; j++) {
                Coordinate c = new Coordinate(i, j);
                array[i][j] = 0;

                for (Coordinate coordinate : list) {
                    int distance = coordinate.distance(c);
                    array[i][j] += distance;
                }

                if (array[i][j] < limit)
                    result2++;
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
