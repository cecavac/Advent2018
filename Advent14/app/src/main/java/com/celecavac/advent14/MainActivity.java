package com.celecavac.advent14;

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

        RecipeLog fancyObject = new RecipeLog(Inputs.input3);
        fancyObject.work1();
        RecipeLog fancyObject2 = new RecipeLog(Inputs.input3);
        fancyObject2.work2();
        textView1.setText(fancyObject.getResult());
        textView2.setText(fancyObject2.getResult2());
    }
}
