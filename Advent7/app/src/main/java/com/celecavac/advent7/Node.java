package com.celecavac.advent7;

import android.support.annotation.NonNull;

import java.util.ArrayList;

import static com.celecavac.advent7.Inputs.BASE_TIME;

public class Node implements Comparable<Node> {
    private static String SQEUENCE = "";
    public static char NO_BEST = 'Z' + 1;

    private ArrayList<Node> children = new ArrayList<Node>();
    private char value;
    private boolean visited = false;
    private boolean workInProgress = false;
    private int lock = 0;
    private int time = BASE_TIME;

    public Node(char value) {
        this.value = value;
        time += value - 'A' + 1;
    }

    public char getValue() {
        return value;
    }

    public char getBest() {
        if (!visited)
            return value;

        char  best = NO_BEST;

        for (Node node : children) {
            if (node.lock > 0)
                continue;

            if (node.visited) {
                char nodesBest = node.getBest();
                if (nodesBest < best)
                    best = nodesBest;
            } else {
                if (node.value < best)
                    best = node.value;
            }
        }

        return best;
    }

    public char getBestForWorking() {
        if (!visited && !workInProgress)
            return value;

        if (!visited && workInProgress)
            return  NO_BEST;

        char  best = NO_BEST;

        for (Node node : children) {
            if (node.lock > 0)
                continue;

            if (node.visited) {
                char nodesBest = node.getBestForWorking();
                if (nodesBest < best)
                    best = nodesBest;
            } else if (!node.workInProgress) {
                if (node.value < best)
                    best = node.value;
            }
        }

        return best;
    }

    public boolean isVisited() {
        return visited;
    }

    public void selectForWorking() {
        workInProgress = true;
    }

    public void tick() {
        time--;

        if (time == 0)
            visit();
    }

    public void visit() {
        visited = true;
        for (Node node : children) {
            node.lock--;
        }
    }

    public void addChild(Node node) {
        if (!children.contains(node)) {
            children.add(node);
            node.lock++;
        }
    }

    @Override
    public int compareTo(@NonNull Node o) {
        return value - o.value;
    }
}
