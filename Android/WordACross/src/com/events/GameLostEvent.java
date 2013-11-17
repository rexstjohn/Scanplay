package com.events;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 9:33 AM
 */
public class GameLostEvent extends GameEvent
{
    private int score;

    //fired when a game_activity_layout was lost
    public GameLostEvent(Object source, int _Score)
    {
        super(source, GAME_LOST_EVENT);
        score = _Score;
    }

    public int getScore() {
        return score;
    }
}
