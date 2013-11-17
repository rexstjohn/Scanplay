package com.models;

import com.events.IGameEvent;
import com.glue.EventBus;
import com.glue.IGameEventListener;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 9:56 AM
 *
 * base class for all models
 */
public class GameModel implements IGameEventListener
{

    //states
    public static final int ACTIVE_STATE = 0;
    public static final int SLEEPING_STATE = 1;

    // state
    protected int state;

    private boolean isDestroyed = false;

    public GameModel()
    {
        EventBus.getInstance().addGameEventListener(this);
    }

    public void notify(IGameEvent event)
    {}

    public void destroy()
    {
        isDestroyed = true;
        EventBus.getInstance().unsubscribe(this);
    }

    public boolean getIsDestroyed()
    {
        return isDestroyed;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }
}
