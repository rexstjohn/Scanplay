package com.models;

import com.events.*;
import com.glue.EventBus;
import org.cocos2d.nodes.CCDirector;
import org.cocos2d.nodes.CCSprite;
import org.cocos2d.nodes.CCSpriteFrame;
import org.cocos2d.types.CGPoint;
import org.cocos2d.types.CGRect;
import org.cocos2d.types.CGSize;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA.
 * User: rexstjohn
 * Date: 7/23/11
 * Time: 11:18 PM
 * To change this template use File | Settings | File Templates.
 */
public class LetterModel extends GameSpriteModel
{
    //globals
    public  static final float LETTER_WIDTH =  CCDirector.sharedDirector().winSize().width / 6;
    public  static final float LETTER_HEIGHT =  CCDirector.sharedDirector().winSize().width / 6;
    public static final float LETTER_VELOCITY = 15f;

    //instance
    private char letterType;//a,b,c etc
    private  boolean isSelected;//is this letter selected?
    private  boolean isFirstSelection;//is this letter the first in a gesture list?
    private int rowIndex;//what row this letter is in it's parent column

    public LetterModel(char _letterType, int _rowIndex)
    {
        super(LETTER_WIDTH, LETTER_HEIGHT, "letter_e.png");
        letterType = _letterType;
        isSelected = false;
        rowIndex = _rowIndex;
        state = SLEEPING_STATE;
    }

    public LetterModel(char _letterType, CCSpriteFrame _sourceFrame, int _rowIndex)
    {
        super(LETTER_WIDTH, LETTER_HEIGHT, _sourceFrame);
        letterType = _letterType;
        isSelected = false;
        rowIndex = _rowIndex;
        state = SLEEPING_STATE;
    }

    @Override
    public void notify(IGameEvent event)
    {
        switch (event.getType())
        {
            case GameEvent.TOUCH_BEGAN_EVENT:
                TouchBeganEvent touchBeganEvent = (TouchBeganEvent)event;
                if(this.contains(touchBeganEvent.getTouchPosition()))
                     handleTouch();
                break;
            case GameEvent.TOUCH_MOVED_EVENT:
                TouchMovedEvent touchMovedEvent = (TouchMovedEvent)event;
                if(this.contains(touchMovedEvent.getTouchPosition()))
                     handleTouchMoveEvent();
                break;
            case GameEvent.TOUCH_ENDED_EVENT:
                TouchEndEvent touchEndEvent = (TouchEndEvent)event;
                break;
        }
    }

    //handle a touch move event
    private void handleTouchMoveEvent()
    {
        if(!isSelected)
        EventBus.getInstance().broadcastGameEvent(new LetterTouchedEvent(this,this));
    }

    //handle a touch event
    private void handleTouch()
    {
        if(!isSelected)
        EventBus.getInstance().broadcastGameEvent(new LetterTouchedEvent(this,this));
    }

    private  void  selectLetter()
    {
        isSelected = true;
    }

    private  void  deselectLetter()
    {
        isSelected = false;
    }

    public char getLetterType()
    {
        return  letterType;
    }

    public boolean getIsFirstSelection()
    {
        return  isFirstSelection;
    }

    public  boolean  getSelected()
    {
        return  isSelected;
    }

    public  void  setSelected(boolean  _selected)
    {
       isSelected = _selected;

        if(isSelected)
            setOpacity(150);
        else
            setOpacity(255);
    }

    public void setIsFirstSelection(boolean _isFirst)
    {
        isFirstSelection = _isFirst;
    }

    public int getRowIndex() {
        return rowIndex;
    }

    public void setRowIndex(int rowIndex) {
        this.rowIndex = rowIndex;
    }
}
