package com.celecavac.advent14;

import android.util.Log;

import java.util.ArrayList;

public class RecipeLog {
    private static boolean DEBUG = false;
    private String result = "";
    private String result2 = "";
    private ArrayList<Integer> list = new ArrayList<Integer>();
    private int elfA = 0, elfB = 1;
    private int goal;
    private int goalDigits = 0;

    public RecipeLog(int goal) {
        list.add(3);
        list.add(7);
        this.goal = goal;

        while (goal != 0) {
            goalDigits++;
            goal /= 10;
        }
    }

    public void commonWork() {
        int recipeA = list.get(elfA);
        int recipeB = list.get(elfB);
        int newRecipe = recipeA + recipeB;

        if (newRecipe < 10) {
            list.add(newRecipe);
        } else {
            list.add(newRecipe / 10);
            list.add(newRecipe % 10);
        }

        elfA = (elfA + recipeA + 1) % list.size();
        elfB = (elfB + recipeB + 1) % list.size();

        print();
    }

    public void work1() {
        while (goal + 10 > list.size()) {
            commonWork();
        }
    }

    private boolean stop() {
        if (list.size() < 7)
            return false;

        int a = 0, b = 0;
        for (int i = goalDigits; i > 0; i--) {
            a = a * 10 + list.get(list.size() - i);
            b = b * 10 + list.get(list.size() - i - 1);
        }

        if (a == goal) {
            int index = list.size() - goalDigits;
            result2 += index;
            return true;
        }

        if (b == goal) {
            int index = list.size() - goalDigits - 1;
            result2 += index;
            return true;
        }

        return false;
    }

    public void work2() {
        while (!stop()) {
            commonWork();
        }
    }

    private void print() {
        if (!DEBUG)
            return;

        StringBuilder stringBuilder = new StringBuilder();

        for (int i = 0; i < list.size(); i++) {
            if (i == elfA) {
                stringBuilder.append('(');
            } else if (i == elfB) {
                stringBuilder.append('[');
            } else {
                stringBuilder.append(' ');
            }

            stringBuilder.append(list.get(i));

            if (i == elfA) {
                stringBuilder.append(')');
            } else if (i == elfB) {
                stringBuilder.append(']');
            } else {
                stringBuilder.append(' ');
            }
        }

        Log.e("Recipes", stringBuilder.toString());
    }

    public String getResult() {
        for (int i = goal; i < goal + 10; i++)
            result += list.get(i);

        return result;
    }

    public String getResult2() {
        return result2;
    }
}
