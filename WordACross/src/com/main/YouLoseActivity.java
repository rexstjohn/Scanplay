package com.main;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;
/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 8/27/11
 * Time: 11:23 PM
 */
public class YouLoseActivity extends Activity
{
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.you_lose_activity_layout);

        Bundle extras = getIntent().getExtras();
        TextView yourScore = (TextView) findViewById(R.id.your_score_label);
        yourScore.setText("Your Score: " + extras.getInt("gameScore"));

    }

    //timed challenge game
    public void backToMainMenu(View view)
    {
        Intent mainMenuActivity = new Intent(view.getContext(), MainMenuActivity.class);
        startActivityForResult(mainMenuActivity, 0);
    }


    @Override
    public void onBackPressed()
    {}
}