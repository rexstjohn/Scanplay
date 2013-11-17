package com.events;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 8/30/11
 * Time: 8:16 PM
 */
public class GamePausedEvent extends GameEvent
{
    public GamePausedEvent(Object source)
    {
        super(source, GAME_PAUSED_EVENT);
    }
}
