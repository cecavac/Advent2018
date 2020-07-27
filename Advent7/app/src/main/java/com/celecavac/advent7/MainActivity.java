package com.celecavac.advent7;

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

        Graph fancyObject = new Graph(Inputs.input1);
        fancyObject.walk();
        textView1.setText(fancyObject.getResult());
        TeamworkGraph fancyObject2 = new TeamworkGraph(Inputs.input1);
        fancyObject2.walk();
        textView2.setText(fancyObject2.getResult());
    }
}
