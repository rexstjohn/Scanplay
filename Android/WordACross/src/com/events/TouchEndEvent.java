package com.events;

import org.cocos2d.types.CGPoint;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 9:39 AM
 */
public class TouchEndEvent extends GameEvent
{
    private CGPoint touchPosition;

    //fired when a screen touch finishes
    public TouchEndEvent(Object source, CGPoint _touchPosition)
    {
        super(source, TOUCH_ENDED_EVENT);
        touchPosition = _touchPosition;
    }

    public CGPoint getTouchPosition() {
        return touchPosition;
    }

    public void setTouchPosition(CGPoint touchPosition) {
        this.touchPosition = touchPosition;
    }
}
