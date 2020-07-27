package com.celecavac.advent2;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {
    private TextView textView1;
    private TextView textView2;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        textView1 = (TextView) findViewById(R.id.textView1);
        textView2 = (TextView) findViewById(R.id.textView2);

        IdLetterCounter idLetterCounter = new IdLetterCounter(Inputs.input1);
        textView1.setText(idLetterCounter.getResult());

        CommonIdFinder commonIdFinder = new CommonIdFinder(Inputs.input1);
        textView2.setText(commonIdFinder.getResult());
    }
}
