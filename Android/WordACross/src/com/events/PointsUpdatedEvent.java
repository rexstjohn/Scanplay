package com.events;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/27/11
 * Time: 9:21 PM
 */
public class PointsUpdatedEvent extends GameEvent
{
    private int totalPoints;  //number of points

    //fired when points are scored
    public PointsUpdatedEvent(Object source, int _points)
    {
        super(source, POINTS_UPDATED_EVENT);
        totalPoints = _points;
    }

    public int getTotalPoints() {
        return totalPoints;
    }
}