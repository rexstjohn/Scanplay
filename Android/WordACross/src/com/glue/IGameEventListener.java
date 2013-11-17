package com.glue;

import com.events.IGameEvent;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 1:09 AM
 */
public interface IGameEventListener
{
    public void notify(IGameEvent event);
    public void destroy();
    public boolean getIsDestroyed();
}
