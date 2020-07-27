package com.celecavac.advent5;

public class ReactorRoller {
    private int result;

    public ReactorRoller(String input) {
        int min = Integer.MAX_VALUE;

        for (char i = 'a'; i <= 'z' ; i++) {
            int z = 0;
            char []array = input.toCharArray();
            for (int j = 0; j < array.length; j++)
                if (array[j] != i && array[j] != (i - ('a' - 'A')))
                    array[z++] = array[j];

            String reactorInput = String.valueOf(array);
            reactorInput = reactorInput.substring(0, z);

            PolymerReactor reactor = new PolymerReactor(reactorInput);
            if (reactor.getIntResult() < min)
                min = reactor.getIntResult();
        }

        result = min;
    }

    public String getResult() {
        return Integer.toString(result);
    }
}
