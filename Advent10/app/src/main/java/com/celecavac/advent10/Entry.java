package com.celecavac.advent10;

public class Entry {
    int x;
    int y;
    int vX;
    int vY;

    public Entry(int x, int y, int vX, int vY) {
        this.x = x;
        this.y = y;
        this.vX = vX;
        this.vY = vY;
    }

    public void tick() {
        x += vX;
        y += vY;
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }
}
