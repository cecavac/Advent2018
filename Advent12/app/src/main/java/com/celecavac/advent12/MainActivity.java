package com.celecavac.advent12;

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

        Potter fancyObject = new Potter(Inputs.input2, 20);
        textView1.setText(fancyObject.getResult());
        Potter fancyObject2 = new Potter(Inputs.input2, 100);
        fancyObject2.completeLongIterationCycle(50000000000L);
        textView2.setText(fancyObject2.getResult());
    }
}
