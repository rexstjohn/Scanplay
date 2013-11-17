package com.events;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 8/30/11
 * Time: 8:16 PM
 */
public class GameResumedEvent extends GameEvent
{
    public GameResumedEvent(Object source)
    {
        super(source, GAME_RESUMED_EVENT);
    }
}
