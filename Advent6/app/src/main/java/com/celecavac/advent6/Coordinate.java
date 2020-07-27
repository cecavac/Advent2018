package com.celecavac.advent6;

public class Coordinate {
    private int x;
    private int y;

    public Coordinate(String input) {
        String []splitInput = input.split(",");

        x = Integer.parseInt(splitInput[0]);
        y = Integer.parseInt(splitInput[1].substring(1));

        /* translate all points by 100,100 */
        x += 100;
        y += 100;
    }

    public Coordinate(int x, int y) {
        this.x = x;
        this.y = y;
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }

    public int distance(Coordinate c) {
        int ret = Math.abs(x - c.x) + Math.abs(y - c.y);
        return ret;
    }
}
