package com.events;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/27/11
 * Time: 9:24 PM
 */
public class LevelUpdatedEvent extends GameEvent
{
    private int totalLevels;  //number of points

    //fired when points are scored
    public LevelUpdatedEvent(Object source, int _levels)
    {
        super(source, LEVEL_UPDATED_EVENT);
        totalLevels = _levels;
    }

    public int getTotalLevels() {
        return totalLevels;
    }
}