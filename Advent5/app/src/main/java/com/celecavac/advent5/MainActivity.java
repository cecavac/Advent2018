package com.celecavac.advent5;

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

        PolymerReactor fancyObject = new PolymerReactor(Inputs.input1);
        textView1.setText(fancyObject.getResult());
        ReactorRoller fancyObject2 = new ReactorRoller(Inputs.input1);
        textView2.setText(fancyObject2.getResult());
    }
}
