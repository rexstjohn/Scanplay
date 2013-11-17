package com.events;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 8/26/11
 * Time: 9:49 PM
 */
public class GameTickEvent  extends  GameEvent
{
    //fired when a game_activity_layout was lost
    public GameTickEvent(Object source)
    {
        super(source, GAME_TICK_EVENT);
    }
}
