package com.models;

import com.events.SpriteFinishedMovingEvent;
import com.events.SpriteWasDestroyedEvent;
import com.glue.EventBus;
import org.cocos2d.actions.instant.CCCallFuncN;
import org.cocos2d.actions.interval.CCMoveTo;
import org.cocos2d.actions.interval.CCSequence;
import org.cocos2d.nodes.CCDirector;
import org.cocos2d.nodes.CCSprite;
import org.cocos2d.nodes.CCSpriteFrame;
import org.cocos2d.types.CGPoint;
import org.cocos2d.types.CGRect;
import org.cocos2d.types.CGSize;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 3:17 PM
 */
public class GameSpriteModel  extends GameModel
{

    //instance
    protected CCSprite sprite;
    protected char letterType;//a,b,c etc
    protected  boolean isSelected;//is this letter selected?
    protected  boolean isFirstSelection;//is this letter the first in a gesture list?

    //height and width
    protected float height;
    protected float width;

    //is this on stage?
    protected boolean isAddedToScene = false;
    protected boolean isBeingRemoved = false;

    //action queu
    private ArrayList<MovementActionModel> moveActions;//list of motions to be performed
    private boolean isPerformingAction;

    public GameSpriteModel(float _width, float _height, String graphic)
    {
        super();
        sprite = CCSprite.sprite(graphic);
        height = _height;
        width  = _width;
        isPerformingAction = false;
        setSize(CGSize.make(width, height));
        moveActions = new ArrayList<MovementActionModel>();
    }

    @Override
    public void destroy()
    {
        EventBus.getInstance().broadcastGameEvent(new SpriteWasDestroyedEvent(this,this));
         moveActions = null;
        if(sprite != null)sprite.cleanup();
        sprite = null;
        super.destroy();
    }

    public GameSpriteModel(float _width, float _height, CCSpriteFrame _sourceFrame)
    {
        super();
        sprite = CCSprite.sprite(_sourceFrame);
        height = _height;
        width  = _width;
        isPerformingAction = false;
        setSize(CGSize.make(width, height));
        moveActions = new ArrayList<MovementActionModel>();
    }


    //scale the image to a specific dimension
    public void setSize(CGSize size)
    {
        float xScale;
        float yScale;

        float currentAspectRatio = sprite.getContentSize().width / sprite.getContentSize().height;
        float desiredAspectRatio = size.getWidth() / size.getHeight();

        if(currentAspectRatio > desiredAspectRatio)
        {
            xScale = getWidth() / width;
            yScale = getHeight() / height;
        }
        else
        {
            xScale =  width / getWidth();
            yScale =  height / getHeight();
        }

        sprite.setScaleX(xScale);
        sprite.setScaleY(yScale);
    }

    public CGSize getSize()
    {
        return  sprite.getContentSize();
    }

    public float getRotation()
    {
       return  sprite.getRotation();
    }

    public void setRotation(float rotation)
    {
       sprite.setRotation(rotation);
    }


    //checks to see if the letter is being touched
    public boolean contains(CGPoint _touchPointPosition)
    {
       //check if the touch hits this rectangle
        if(getHitRectangle().contains(_touchPointPosition.x, _touchPointPosition.y))
            return true;
        else
            return false;
    }

    //checks to see if the letter is hitting another letter
    public  boolean intersects(LetterModel _letter)
    {
         return(CGRect.intersects(getHitRectangle(), _letter.getHitRectangle()));
    }

    public  CGRect getHitRectangle()
    {
       //update the hit rectangle
        //note - we need to move the rectangle so it's origin is not at the center of the sprite
        CGRect hitRectangle = new CGRect();
       hitRectangle.set(getX() - (getWidth() / 2),
                        getY() - (getHeight() / 2),
                        getWidth(),
                        getHeight());

        return hitRectangle;
    }

    public CCSprite getSprite()
    {
        return  sprite;
    }

    public CGPoint getPosition()
    {
        return sprite.getPosition();
    }

    public void setPosition(CGPoint _position)
    {
        sprite.setPosition(_position);
    }

    public  float getWidth()
    {
        return  sprite.getContentSize().getWidth() * sprite.getScaleX();
    }

    public  float getHeight()
    {
        return  sprite.getContentSize().getHeight()* sprite.getScaleY();
    }

    public boolean isAddedToScene()
    {
        return isAddedToScene;
    }

    public void setIsAddedToScene(boolean _isAdded)
    {
        isAddedToScene = _isAdded;
    }

    public float getX()
    {
        return  sprite.getPosition().x;
    }

    public float getY()
    {
        return  sprite.getPosition().y;
    }

    //creates a movement action and adds it to the list of actions to be completed
    public void moveToPoint(CGPoint _target, int _actionType)
    {
		// Determine the length of how far we're moving
		int dx = (int)(getX() - _target.x);
		int dy = (int)(getY() - _target.y);
		float length = (float)Math.sqrt((dx * dx) + (dy * dy));
		float realMoveDuration = length / (float)((getHeight() * 10)/1.0f);

        String actionSelector;

        switch (_actionType)
        {
             case MovementActionModel.GO_TO_AND_REMOVE_ACTION:
                 actionSelector =  "destroyActingSprite";
                 break;
             default:
                 actionSelector =  "didFinishMovementAction";
                 break;
        }

        // Move sprite to actual endpoint
        sprite.runAction(CCSequence.actions(
                CCMoveTo.action(realMoveDuration, _target),
                CCCallFuncN.action(this, actionSelector)));
    }

    private void didFinishMovementAction(Object sender)
    {

    }

    //used to get the letters off the stage
    public void animateOutAndDestroy()
    {
       isBeingRemoved = true;
       CGPoint target = CGPoint.make(CCDirector.sharedDirector().winSize().getWidth()/2, 0);
       moveToPoint(target,MovementActionModel.GO_TO_AND_REMOVE_ACTION);
    }

    //used to get the letters off the stage  randomly
    public void animateOutAndDestroyRandomly()
    {
       isBeingRemoved = true;
       double randomX = Math.random() *  CCDirector.sharedDirector().winSize().getWidth();
       double randomY = Math.random() *  CCDirector.sharedDirector().winSize().getHeight();
       CGPoint target = CGPoint.make((float)randomX,(float)randomY);
       moveToPoint(target,MovementActionModel.GO_TO_AND_REMOVE_ACTION);
    }

    //destroys this sprite when the action is completed
    public void destroyActingSprite(Object sender)
    {
        sprite.stopAllActions();
        destroy();
    }

    public void setVisible(boolean _visible)
    {
        sprite.setVisible(_visible);
    }

    public  void setOpacity(int opacity)
    {
        sprite.setOpacity(opacity);
    }

    public boolean getIsBeingRemoved()
    {
        return isBeingRemoved;
    }
}
