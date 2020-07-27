package com.celecavac.advent13;

import android.util.Log;

import java.util.ArrayList;
import java.util.Collections;

public class Traffic {
    public static int WIDTH = 150;
    private char map[][];
    private ArrayList<Cart> carts = new ArrayList<Cart>();
    private String result = null;
    private String result2 = "Remaining cart: ";
    private static boolean DEBUG = false;

    public Traffic(String input) {
        String split[] = input.split("\\n");
        map = new char[split.length][WIDTH];
        for (int i = 0; i < split.length; i++) {
            char line[] = split[i].toCharArray();
            for (int j = 0; j < line.length; j++) {
                map[i][j] = line[j];
                examinePosition(i, j);
            }
        }
    }

    private boolean isCart(int i, int j) {
        if (map[i][j] == '<' ||
                map[i][j] == '^' ||
                map[i][j] == '>' ||
                map[i][j] == 'v')
            return true;

        return false;
    }

    private void examinePosition(int i, int j) {
        if (isCart(i, j)) {
            Cart cart = new Cart(map[i][j], i, j, map);
            carts.add(cart);

            if (map[i][j] == '<' || map[i][j] == '>') {
                map[i][j] = '-';
            } else {
                map[i][j] = '|';
            }
        }
    }

    public void roll() {
        print();

        outer: while (true) {
            int colided = 0;
            Collections.sort(carts);

            for (Cart cart : carts) {
                if (cart.isCollided())
                    colided++;
            }

            if (colided + 1 >= carts.size())
                break outer;

            for (Cart cart : carts) {

                cart.move();
                for (Cart otherCart : carts)
                    if (cart.colides(otherCart)) {
                        colided += 2;

                        if (result == null)
                            result = cart.getCoordinates();
                    }
            }

            print();
        }

        for (Cart cart : carts) {
            if (!cart.isCollided())
                result2 += cart.getCoordinates();
        }

        print();
    }

    public void print() {
        if (!DEBUG)
            return;

        char printMap[][] = new char[map.length][WIDTH];

        for (int i = 0; i < map.length; i++)
            for (int j = 0; j < WIDTH; j++)
                printMap[i][j] = map[i][j];

        for (Cart cart : carts)
            printMap[cart.getI()][cart.getJ()] = cart.getDirection();

        for (int i = 0; i < map.length; i++) {
            String line = new String(printMap[i]);
            //line = line.substring(0, 13);
            Log.e("LINE", line);
        }

        Log.e("LINE", "=============");
    }

    public String getResult() {
        return result;
    }

    public String getResult2() {
        return result2;
    }
}
