package com.utils;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import com.main.R;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 8/5/11
 * Time: 6:50 PM
 */
public class GameDialogue extends Dialog {

    public interface ReadyListener {
        public void ready(String name);
    }

    private String name;

    public GameDialogue(Context context, String name) {
        super(context);
        this.name = name;
    }

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.game_dialogue_layout);
        setTitle("Enter your Name ");

        Button buttonOK = (Button) findViewById(R.id.close);
        buttonOK.setOnClickListener(new OKListener());
    }

    private class OKListener implements android.view.View.OnClickListener
    {
        //@Override
        public void onClick(View v)
        {
            //readyListener.ready(String.valueOf(etName.getText()));
            GameDialogue.this.dismiss();
        }
    }

    public static void showDialogue(String title, String message)
    {
        /*
        new AlertDialog.Builder(SharedContext.context)
            .setTitle(title)
            .setMessage(message)
            .setPositiveButton("OK", new DialogInterface.OnClickListener()
            {
                public void onClick(DialogInterface arg0, int arg1) {
                    // Some stuff to do when ok got clicked
                }
            })
            .show();
            */
    }

}