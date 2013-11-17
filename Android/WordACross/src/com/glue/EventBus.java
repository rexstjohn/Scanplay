package com.glue;

import android.util.Log;
import com.events.IGameEvent;
import com.models.LetterColumnModel;

import java.util.ArrayList;
import java.util.Iterator;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 9:14 AM
 */
public class EventBus
{
    private static EventBus instance = null;
    private static ArrayList<IGameEventListener> listeners;

    public synchronized static EventBus getInstance()
    {
        if(instance == null)
        {
             instance = new EventBus();
            listeners = new ArrayList<IGameEventListener>();
        }
        return instance;
    }

    public synchronized void removeGameEventListener(IGameEventListener _listener)
    {
          listeners.remove(_listener);
    }

    public synchronized void  addGameEventListener(IGameEventListener _listener)
    {
        listeners.add(_listener);
    }

    public synchronized void broadcastGameEvent(IGameEvent event)
    {
        //dispatch the fact an event has occurred
        //clone the list to avoid concurrent modification issues
        Iterator _listeners = ((ArrayList<IGameEventListener>)listeners.clone()).iterator();

        while( _listeners.hasNext() )
        {
            ( (IGameEventListener) _listeners.next() ).notify(event);
        }
    }

    public synchronized void unsubscribe(IGameEventListener _listener)
    {
        if(_listener == null || !listeners.contains(_listener)) return;


        int indexToRemove = 0;

         for(int i = 0; i < listeners.size(); i++)
         {
             if(listeners.get(i) == _listener)
             {
                 indexToRemove = i;
                 break;
             }
         }

         listeners.remove(indexToRemove);
    }

    public static void reset()
    {
        listeners.removeAll(listeners);
    }
}
