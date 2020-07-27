package com.celecavac.advent4;

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

        GuardWatcher guardWatcher = new GuardWatcher(Inputs.input1);
        textView1.setText(guardWatcher.getResult());
        textView2.setText(guardWatcher.getResult2());
    }
}
