package com.events;

import org.cocos2d.types.CGPoint;
import org.cocos2d.types.CGSize;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 9:37 AM
 */
public class TouchBeganEvent extends GameEvent
{
    private CGPoint touchPosition;

    //fired when a screen touch occurs
    public TouchBeganEvent(Object source, CGPoint _touchPosition)
    {
        super(source, TOUCH_BEGAN_EVENT);
        touchPosition = _touchPosition;
    }

    public CGPoint getTouchPosition() {
        return touchPosition;
    }

    public void setTouchPosition(CGPoint touchPosition) {
        this.touchPosition = touchPosition;
    }
}
