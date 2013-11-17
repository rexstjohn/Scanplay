package com.views;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.Canvas;
import android.graphics.drawable.Drawable;
import android.view.View;
import com.main.R;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 8/27/11
 * Time: 12:08 PM
 *
 * Does some cool animated stuff while game is loading
 */
public class LoadingView  extends View
{
       private Drawable exampleLetter;

       public LoadingView(Context context)
       {
            super(context);
            setFocusable(true);

       }

        @Override
        protected void onDraw(Canvas canvas)
        {
            invalidate();
        }
}
