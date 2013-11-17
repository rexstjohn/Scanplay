package com.events;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 9:30 AM
 */
public class StartGameEvent extends GameEvent
{
    //fired when a new game_activity_layout needs to be created
    public StartGameEvent(Object source)
    {
        super(source, START_GAME_EVENT);
    }
}
