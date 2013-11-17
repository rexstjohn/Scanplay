package com.events;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 8/11/11
 * Time: 9:36 PM
 */
public class NotAWordEvent extends GameEvent
{
    public NotAWordEvent(Object source)
    {
        super(source, NOT_A_WORD_EVENT);
    }

}
