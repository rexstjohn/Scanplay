package com.events;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 10:28 AM
 */
public class QuitGameEvent extends GameEvent
{
     //fired when a new game_activity_layout needs to be created
    public QuitGameEvent(Object source)
    {
        super(source, QUIT_GAME_EVENT);
    }
}
