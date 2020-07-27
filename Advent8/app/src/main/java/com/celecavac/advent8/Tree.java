package com.celecavac.advent8;

public class Tree {
    private Node root;
    private int result;
    private int result2;

    public Tree(String input) {
        String split[] = input.split(" ");
        int values[] = new int[split.length];

        for (int i = 0; i < split.length; i++)
            values[i] = Integer.parseInt(split[i]);

        root = getChild(values, 0, 0);
    }

    public Node getChild(int []values, int index, int depth) {
        Node node = new Node();
        int children = values[index++];
        int meta = values[index++];

        if (children > 0) {
            for(int i = 0; i < children; i++) {
                Node child = getChild(values, index, depth + 1);
                index = child.getLastIndex();
                node.addChild(child);
            }
        }

        for(int i = 0; i < meta; i++)
            node.addMeta(values[index++]);

        node.setLastIndex(index);
        return node;
    }

    public void walk() {
        result = root.getSum();
        result2 = root.getComplexSum();
    }

    public String getResult() {
        return Integer.toString(result);
    }

    public String getResult2() {
        return Integer.toString(result2);
    }
}
