package com.models;

import org.cocos2d.types.CGPoint;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/25/11
 * Time: 7:49 PM
 */
public class MovementActionModel extends GameModel
{
    public static final int GO_TO_AND_REMOVE_ACTION = 0;
    public static final int GO_TO_AND_DO_NEXT_ACTION = 1;   //destroy the object when the action is finished

    private CGPoint movementTarget;
    private float movementDuration;
    private int actionType;

    public MovementActionModel(CGPoint _target, float movementDuration,int _actionType)
    {
        super();
        this.movementTarget = _target;
        this.movementDuration = movementDuration;
        this.actionType = _actionType;
    }

    public CGPoint getTarget() {
        return movementTarget;
    }

    public void setTarget(CGPoint _target) {
        this.movementTarget = _target;
    }

    public float getMovementDuration() {
        return movementDuration;
    }

    public int getActionType() {
        return actionType;
    }
}
