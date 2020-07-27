package com.celecavac.advent9;

import android.util.Log;

public class Game {
    private long result;
    private long []score;
    private int lastMarble;
    private Queue queue;
    private static boolean DEBUG = false;

    public Game(String input) {
        String split[] = input.split(" ");
        int players = Integer.parseInt(split[0]);
        lastMarble = Integer.parseInt(split[6]);
        score = new long[players];
    }

    public void play() {
        /* First element */
        long marbleValue = 0;
        int player = 0;
        queue = new Queue(marbleValue);
        printState(player);


        while (marbleValue < lastMarble) {
            marbleValue++;
            player = (player + 1) % score.length;

            if (marbleValue % 23 != 0) {
                queue.add(marbleValue);
            } else {
                score[player] += marbleValue;
                score[player] += queue.remove();
            }

            printState(player);
        }

        result = getTheHighestScore();
    }

    private long getTheHighestScore() {
        long max = 0;
        for (long playerScore : score)
            if (max < playerScore)
                max = playerScore;

        return  max;
    }

    private void printState(int player) {
        if (!DEBUG)
            return;

        /* Match the player number in the example */
        player++;

        Log.e("Game", "[" + player + "] " + queue.toString());
    }

    public String getResult() {
        return Long.toString(result);
    }
}
