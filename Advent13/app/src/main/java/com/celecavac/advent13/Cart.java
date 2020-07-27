package com.celecavac.advent13;

import android.support.annotation.NonNull;

public class Cart implements Comparable<Cart> {
    public enum Direction {
        LEFT,
        UP,
        RIGHT,
        DOWN
    }
    public enum Turn {
        LEFT,
        STRAIGHT,
        RIGHT
    }

    private int i, j;
    private Direction direction;
    private Turn nextTurn = Turn.LEFT;
    private char map[][];
    private boolean collided = false;

    public Cart(char c, int i, int j, char map[][]) {
        switch (c) {
            case '^':
                direction = Direction.UP;
                break;
            case 'v':
                direction = Direction.DOWN;
                break;
            case '<':
                direction = Direction.LEFT;
                break;
            case '>':
                direction = Direction.RIGHT;
                break;
        }

        this.i = i;
        this.j = j;
        this.map = map;
    }

    public boolean isCorner() {
        if (map[i][j] == '\\' || map[i][j] == '/') {
            return true;
        } else {
            return  false;
        }
    }

    public boolean isIntersection() {
        if (map[i][j] == '+') {
            return true;
        } else {
            return  false;
        }
    }

    public void cornerTurn() {
        char c = map[i][j];

        switch (direction) {
            case UP:
                switch(c) {
                    case '/':
                        direction = Direction.RIGHT;
                        break;
                    case '\\':
                        direction = Direction.LEFT;
                        break;
                }
                break;
            case DOWN:
                switch(c) {
                    case '/':
                        direction = Direction.LEFT;
                        break;
                    case '\\':
                        direction = Direction.RIGHT;
                        break;
                }
                break;
            case LEFT:
                switch(c) {
                    case '/':
                        direction = Direction.DOWN;
                        break;
                    case '\\':
                        direction = Direction.UP;
                        break;
                }
                break;
            case RIGHT:
                switch(c) {
                    case '/':
                        direction = Direction.UP;
                        break;
                    case '\\':
                        direction = Direction.DOWN;
                        break;
                }
                break;
        }
    }

    public char getDirection() {
        if (collided)
            return 'X';

        switch (direction) {
            case LEFT:
                return '<';
            case UP:
                return '^';
            case RIGHT:
                return '>';
            case DOWN:
                return 'v';
            default:
                return 'F';
        }
    }

    private void intersectionMovement() {
        switch (nextTurn) {
            case LEFT:
                switch (direction) {
                    case LEFT:
                        direction = Direction.DOWN;
                        break;
                    case UP:
                        direction = Direction.LEFT;
                        break;
                    case RIGHT:
                        direction = Direction.UP;
                        break;
                    case DOWN:
                        direction = Direction.RIGHT;
                        break;
                }
                nextTurn = Turn.STRAIGHT;
                break;
            case STRAIGHT:
                nextTurn = Turn.RIGHT;
                break;
            case RIGHT:
                switch (direction) {
                    case LEFT:
                        direction = Direction.UP;
                        break;
                    case UP:
                        direction = Direction.RIGHT;
                        break;
                    case RIGHT:
                        direction = Direction.DOWN;
                        break;
                    case DOWN:
                        direction = Direction.LEFT;
                        break;
                }
                nextTurn = Turn.LEFT;
                break;
        }
    }

    public void move() {
        if (collided)
            return;;

        switch (direction) {
            case LEFT:
                j--;
                break;
            case UP:
                i--;
                break;
            case RIGHT:
                j++;
                break;
            case DOWN:
                i++;
                break;
        }

        if (isCorner())
            cornerTurn();

        if (isIntersection())
            intersectionMovement();
    }

    public String getCoordinates() {
        return j + "," + i;
    }

    public boolean colides(Cart cart) {
        if (this == cart)
            return false;

        if (collided || cart.isCollided())
            return false;

        boolean crash = i == cart.i && j == cart.j;

        if (crash) {
            collided = true;
            cart.collided = true;
        }

        return crash;
    }

    public int getI() {
        return i;
    }

    public int getJ() {
        return j;
    }

    public boolean isCollided() {
        return collided;
    }

    private int getSimplePosition() {
        return i*Traffic.WIDTH + j;
    }

    @Override
    public int compareTo(@NonNull Cart o) {
        return getSimplePosition() - o.getSimplePosition();
    }
}
