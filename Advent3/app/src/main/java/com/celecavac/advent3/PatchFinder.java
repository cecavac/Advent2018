package com.celecavac.advent3;

import java.util.HashMap;

public class PatchFinder {
    private int [][]patch = new int[1000][1000];
    private int result = 0;
    private HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();

    public PatchFinder(String input) {
        String split[] = input.split("\\n");

        for (String entry : split) {
            entry = entry.replace('#', ' ');
            entry = entry.replace('@', ' ');
            entry = entry.replace(',', ' ');
            entry = entry.replace(':', ' ');
            entry = entry.replace('x', ' ');

            String entrySplit[] = entry.split(" ");

            int id = Integer.parseInt(entrySplit[1]);
            int x = Integer.parseInt(entrySplit[4]);
            int y = Integer.parseInt(entrySplit[5]);
            int w = Integer.parseInt(entrySplit[7]);
            int h = Integer.parseInt(entrySplit[8]);
            boolean collisionFree = true;

            for (int i = x; i < x + w; i++)
                for (int j = y; j < y + h; j++) {
                    if (patch[i][j] == 0) {
                        patch[i][j] = id;
                    } else if (patch[i][j] != -1) {
                        map.remove(patch[i][j]);
                        map.remove(id);
                        collisionFree = false;

                        patch[i][j] = -1;
                        result++;
                    } else {
                        map.remove(patch[i][j]);
                        map.remove(id);
                        collisionFree = false;
                    }
                }

            if (collisionFree)
                map.put(id, 0);
        }
    }

    public String getResult() {
        return Integer.toString(result);
    }

    public String getResult2() {
        return map.toString();
    }
}
