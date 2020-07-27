package com.celecavac.advent5;

public class PolymerReactor {
    private String result;

    public PolymerReactor(String input) {
        char []array = input.toCharArray();
        int len = array.length;
        int offset = Math.abs('a' - 'A');
        boolean changed;

        do {
            changed = false;
            int j = 0;

            for (int i = 1; i < len; i++) {
                if (Math.abs(array[i - 1] - array[i]) == offset) {
                    i++;
                    if (i + 1 == len)
                        array[j++] = array[i];

                    changed = true;
                    continue;
                }

                array[j++] = array[i-1];
                if (i + 1 == len)
                    array[j++] = array[i];
            }

            len = j;
        } while (changed);

        result = Integer.toString(len);

    }

    public String getResult() {
        return result;
    }

    public int getIntResult() {
        return Integer.parseInt(result);
    }
}

