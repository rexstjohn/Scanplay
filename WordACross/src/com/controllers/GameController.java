package com.controllers;

import com.events.IGameEvent;
import com.glue.EventBus;
import com.glue.IGameEventListener;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 9:54 AM
 *
 * Base class from which all controllers inherit
 */
public class GameController implements IGameEventListener
{
    private boolean isDestroyed = false;

    public GameController()
    {
        EventBus.getInstance().addGameEventListener(this);
    }

    public void notify(IGameEvent event)
    {}

    public void destroy()
    {
        isDestroyed=true;
        EventBus.getInstance().unsubscribe(this);
    }

    public boolean getIsDestroyed()
    {
        return isDestroyed;
    }
}
