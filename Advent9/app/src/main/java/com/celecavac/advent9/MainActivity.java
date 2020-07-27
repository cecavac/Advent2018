package com.celecavac.advent9;

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

        Game fancyObject = new Game(Inputs.input7);
        fancyObject.play();
        textView1.setText(fancyObject.getResult());

        Game fancyObject2 = new Game(Inputs.input8);
        fancyObject2.play();
        textView2.setText(fancyObject2.getResult());
    }
}
