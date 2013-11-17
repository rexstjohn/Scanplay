package com.main;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;
import com.globals.GameGlobals;
import com.openfeint.api.resource.Leaderboard;
import com.openfeint.api.resource.Score;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 8/4/11
 * Time: 10:36 PM
 */
public class LeaderboardActivity extends Activity
{
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.leaderboard_activity_layout);

        long scoreValue = 100;
        Score s = new Score(scoreValue, null); // Second parameter is null to indicate that custom display text is not used.
        Leaderboard l = new Leaderboard(GameGlobals.leaderBoard);
        s.submitTo(l, new Score.SubmitToCB()
        {
          @Override public void onSuccess(boolean newHighScore)
          { 		// sweet, score was posted
            LeaderboardActivity.this.setResult(Activity.RESULT_OK);
            LeaderboardActivity.this.finish();
          }
          @Override public void onFailure(String exceptionMessage)
          {
            Toast.makeText(LeaderboardActivity.this, "Error (" + exceptionMessage + ") posting score.", Toast.LENGTH_SHORT).show();
            LeaderboardActivity.this.setResult(Activity.RESULT_CANCELED);
            LeaderboardActivity.this.finish();
          }
        });
    }
}