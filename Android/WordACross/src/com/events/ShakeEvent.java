package com.events;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 8/29/11
 * Time: 8:31 PM
 */
public class ShakeEvent extends GameEvent
{
    public ShakeEvent(Object source)
    {
        super(source, SHAKE_EVENT);
    }
}
