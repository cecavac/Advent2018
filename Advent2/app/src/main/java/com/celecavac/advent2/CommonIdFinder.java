package com.celecavac.advent2;

public class CommonIdFinder {
    private String result = "";

    public CommonIdFinder(String frequencies) {
        String split[] = frequencies.split("\\n");

        outer: for (String id1 : split) {
            for (String id2 : split) {
                char []id1Array = id1.toCharArray();
                char []id2Array = id2.toCharArray();
                int charPosition = -1;

                for (int i= 0; i < id1.length(); i++) {
                    if (id1Array[i] != id2Array[i]) {
                        if (charPosition == -1) {
                            charPosition = i;
                        } else {
                            charPosition = -1;
                            break;
                        }
                    }
                }

                if (charPosition != -1) {
                    for (int i= 0; i < id1.length(); i++) {
                        if (charPosition != i)
                            result += id1Array[i];
                    }

                    break outer;
                }
            }
        }
    }

    public String getResult() {
        return result;
    }
}
