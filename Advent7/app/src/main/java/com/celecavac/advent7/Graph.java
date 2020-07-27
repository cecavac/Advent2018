package com.celecavac.advent7;

import android.util.Log;

import java.util.ArrayList;

public class Graph {
    protected Node []nodes = new Node['Z' - 'A' + 1];
    private Node []nodesRequired = new Node['Z' - 'A' + 1];
    private Node []nodesResulted = new Node['Z' - 'A' + 1];
    protected ArrayList<Node> roots = new ArrayList<Node>();
    protected String result = "";

    public Graph(String input) {
        String split[] = input.split("\\n");

        for (String f : split) {
            char value = f.charAt(5);
            char value2 = f.charAt(36);
            int index = value - 'A';
            int index2 = value2 - 'A';

            if (nodes[index] == null)
                nodes[index] = new Node(value);

            if (nodesRequired[index] == null)
                nodesRequired[index] = nodes[index];

            if (nodes[index2] == null)
                nodes[index2] = new Node(value2);

            if (nodesResulted[index2] == null)
                nodesResulted[index2] = nodes[index2];

            nodes[index].addChild(nodes[index2]);
        }

        for (int i = 0; i < nodes.length; i++) {
            if (nodesRequired[i] != null && nodesResulted[i] == null) {
                roots.add(nodesRequired[i]);
            }
        }
    }

    public void walk() {
        while (true) {
            char bestNode = Node.NO_BEST;

            for (Node node : roots) {
                char value = node.getBest();
                if (value < bestNode)
                    bestNode = value;
            }

            if (bestNode == Node.NO_BEST)
                break;

            result += bestNode;
            int index = bestNode - 'A';
            nodes[index].visit();
        }
    }

    public String getResult() {
        Log.e("RESULT", "Copy me: " + result);
        return result;
    }
}
