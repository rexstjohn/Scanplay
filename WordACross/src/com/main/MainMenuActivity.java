package com.main;

import android.app.Activity;
import android.app.Dialog;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.AbsListView;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;
import com.globals.GameGlobals;
import com.openfeint.api.OpenFeint;
import com.openfeint.api.OpenFeintDelegate;
import com.openfeint.api.OpenFeintSettings;
import com.openfeint.gamefeed.GameFeedView;

import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: rexstjohn
 * Date: 7/22/11
 * Time: 6:49 PM
 * To change this template use File | Settings | File Templates.
 */
public class MainMenuActivity extends Activity {

    private    Dialog dialog;

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main_menu_layout);

        //initialize open feint
        /*
        OpenFeintSettings settings =
        new OpenFeintSettings(GameGlobals.gameName, GameGlobals.gameKey, GameGlobals.gameSecret, GameGlobals.gameID);

        OpenFeint.initialize(this, settings, new OpenFeintDelegate()
        {
        });
        */
       // GameFeedView gameFeedView = new GameFeedView(getApplicationContext());
        //gameFeedView.addToLayout(this.findViewById(R.id.main_menu_linear_layout));

        //do some cool animations
        LinearLayout layout = (LinearLayout)findViewById(R.id.main_menu_linear_layout);

        doUIAnimations(layout);
    }

    @Override
    public void onBackPressed()
    {}

    private void doUIAnimations(LinearLayout layout)
    {
        for (int i = 0; i < layout.getChildCount(); i++)
        {
            View v = layout.getChildAt(i);
            Class c = v.getClass();
            if (c == Button.class)
            {
                //do some button animations
                Animation hyperspaceJump =
                    AnimationUtils.loadAnimation(this, R.anim.button_tween);
                Button gameButton = (Button)findViewById(v.getId());
                gameButton.startAnimation(hyperspaceJump);
            } else if (c == TextView.class)
            {
                //animate the text view

            }
        }
    }

    public void closeDialogue(View view)
    {
        dialog.hide();
    }

    //timed challenge game
    public void startBlitzGame(View view)
    {
        Intent gameActivity = new Intent(view.getContext(), GameActivity.class);
        Bundle bundle = new Bundle();
        bundle.putCharSequence("gameMode", "blitzMode");
        gameActivity.putExtras(bundle);
        startActivityForResult(gameActivity, 0);
    }

    //game with no timer or clock
    public void startEndlessGame(View view)
    {
        Intent gameActivity = new Intent(view.getContext(), GameActivity.class);
        Bundle bundle = new Bundle();
        bundle.putCharSequence("gameMode", "endlessMode");
        gameActivity.putExtras(bundle);
        startActivityForResult(gameActivity, 0);
    }

    //game instructions
    public void loadHowToPlay(View view)
    {
        Intent howToPlayActivity = new Intent(view.getContext(), HowToPlayActivity.class);
        startActivityForResult(howToPlayActivity, 0);
    }

    //scores for blitz game and endless game
    public void loadLeaderboards(View view)
    {
        Intent leaderboardActivity = new Intent(view.getContext(), LeaderboardActivity.class);
        startActivityForResult(leaderboardActivity, 0);
    }
}