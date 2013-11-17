package com.events;

import org.cocos2d.types.CGPoint;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 9:45 AM
 */
public class TouchMovedEvent extends GameEvent
{
    private CGPoint touchPosition;

    //fired when a screen touch finishes
    public TouchMovedEvent(Object source, CGPoint _touchPosition)
    {
        super(source, TOUCH_MOVED_EVENT);
        touchPosition = _touchPosition;
    }

    public CGPoint getTouchPosition() {
        return touchPosition;
    }

    public void setTouchPosition(CGPoint touchPosition) {
        this.touchPosition = touchPosition;
    }
}
