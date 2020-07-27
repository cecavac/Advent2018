package com.celecavac.advent7;

import android.util.Log;

import static com.celecavac.advent7.Inputs.WORKER_NUMBER;

public class TeamworkGraph extends Graph {
    private Node []workers = new Node[WORKER_NUMBER];

    public TeamworkGraph(String input) {
        super(input);
    }

    @Override
    public void walk() {
        int second = 0;
        while (true) {
            for (int i = 0; i < workers.length; i++) {
                if (workers[i] != null)
                    continue;

                char bestNode = Node.NO_BEST;

                for (Node node : roots) {
                    char value = node.getBestForWorking();
                    if (value < bestNode)
                        bestNode = value;
                }

                if (bestNode == Node.NO_BEST)
                    break;
                int index = bestNode - 'A';
                nodes[index].selectForWorking();
                workers[i] = nodes[index];
            }

            String tickString = "";
            for (int i = 0; i < workers.length; i++) {
                tickString += "    ";
                if (workers[i] == null) {
                    tickString += ".";
                } else {
                    tickString += workers[i].getValue();
                }
            }

            String second_prefix;
            if (second < 10) {
                second_prefix = "   ";
            } else if (second < 100) {
                second_prefix = "  ";
            } else if (second < 1000) {
                second_prefix = " ";
            } else {
                second_prefix = "";
            }


            Log.e("Tick", "Second: " + second_prefix + second + " " + tickString + "     " + result);

            boolean done = true;
            for (int i = 0; i < workers.length; i++) {
                if (workers[i] != null) {
                    workers[i].tick();
                    done = false;
                }
            }
            if (done)
                break;

            /* Sort */
            for (int i = 0; i < workers.length; i++) {
                for (int j = i + 1; j < workers.length; j++) {
                    if (workers[i] != null && workers[j] != null) {
                        if (workers[i].getValue() > workers[j].getValue()) {
                            Node temp = workers[i];
                            workers[i] = workers[j];
                            workers[j] = temp;
                        }
                    }
                }
            }

            for (int i = 0; i < workers.length; i++) {
                if (workers[i] != null && workers[i].isVisited()) {
                    result += workers[i].getValue();
                    workers[i] = null;
                }
            }

            second++;
        }
        result = "" + second;
    }
}
