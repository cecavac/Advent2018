package com.celecavac.advent8;

import java.util.ArrayList;

public class Node {
    private ArrayList<Node> childrenList = new ArrayList<Node>();
    private ArrayList<Integer> metaList = new ArrayList<Integer>();
    private int lastIndex;

    public void addMeta(int  meta) {
        metaList.add(meta);
    }

    public void addChild(Node node) {
        childrenList.add(node);
    }

    public int getLastIndex() {
        return lastIndex;
    }

    public void setLastIndex(int lastIndex) {
        this.lastIndex = lastIndex;
    }

    public int getSum() {
        int sum = 0;
        for (Node child : childrenList)
            sum += child.getSum();

        for (Integer meta : metaList)
            sum += meta;

        return sum;
    }

    public int getComplexSum() {
        int sum = 0;

        if (childrenList.size() == 0) {
            for (Integer meta : metaList)
                sum += meta;

            return sum;
        } else {
            for (Integer meta : metaList)
                if (meta > 0 && meta <= childrenList.size()) {
                    sum += childrenList.get(meta - 1).getComplexSum();
                }

            return sum;
        }
    }
}
