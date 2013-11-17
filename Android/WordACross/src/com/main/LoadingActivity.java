package com.main;

import android.app.Activity;
import android.content.Intent;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.view.Gravity;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.FrameLayout;
import android.widget.TextView;
import com.globals.GameGlobals;
import com.openfeint.api.OpenFeint;
import com.openfeint.api.OpenFeintDelegate;
import com.openfeint.api.OpenFeintSettings;
import com.utils.GameDictionaryHashMap;
import com.utils.SharedContext;
import com.views.LoadingView;
import android.widget.FrameLayout.LayoutParams;
import android.widget.TextView;

import java.util.ArrayList;

/**
 * Shows a loading screen for a few seconds
 */
public class LoadingActivity extends Activity
{
    private LoadingView loadingView;

    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.loading_activity_layout);

        //created the animated loading view
        FrameLayout frameLayout = (FrameLayout)this.findViewById(R.id.loading_frame_layout);
        this.loadingView = new LoadingView(getApplicationContext());
        frameLayout.addView(loadingView, 0);

        //animate the loading letters
        TextView loadingLetters = (TextView)findViewById(R.id.loading_screen_loading_label);
        Animation hyperspaceJump =
            AnimationUtils.loadAnimation(this, R.anim.game_tween);
        loadingLetters.startAnimation(hyperspaceJump);

        /** create a thread to show splash up to splash time */
        Thread loadingSplashThread = new Thread()
        {
            @Override
            public void run()
            {
                try
                {
                    super.run();
                    SharedContext.context = getApplicationContext();
                    GameDictionaryHashMap.readDictionaryHashFile(getApplicationContext());

               }
               catch (Exception e)
               {
                 System.out.println("EXc=" + e);
               }
               finally
               {
                 startActivity(new Intent(LoadingActivity.this,MainMenuActivity.class));
                 finish();
               }
            }
        };

        loadingSplashThread.start();
    }
}