package com.views;

import android.content.Context;
import android.view.MotionEvent;
import com.events.*;
import com.glue.EventBus;
import com.glue.IGameEventListener;
import com.main.R;
import com.models.SelectionArrowModel;
import org.cocos2d.layers.CCColorLayer;
import org.cocos2d.layers.CCScene;
import org.cocos2d.nodes.CCDirector;
import org.cocos2d.nodes.CCLabel;
import org.cocos2d.nodes.CCSprite;
import org.cocos2d.opengl.CCDrawingPrimitives;
import org.cocos2d.types.CGPoint;
import org.cocos2d.types.CGSize;
import org.cocos2d.types.ccColor3B;
import org.cocos2d.types.ccColor4B;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Timer;
import java.util.TimerTask;

public class GameView extends CCColorLayer implements IGameEventListener
{
    private static final String BACKGROUND_IMAGE = "dark_background.jpg";
    private static final int SHAKE_REMINDER_TIMER = 7000;

    private static CCScene sceneInstance;
    private CGSize winSize;

    //view elements
    private CCLabel scoreLabel;//label for keeping score
    private CCLabel wordLabel;//label for tracking your level

    //input timers to prevent input from overwhelming with broadcast events
    private boolean isMoving = false;
    private CGPoint fingerPosition;

    //has this view been destroyed
    private boolean isDestroyed = false;

    //a timer to remind the user to shake if they get stuck
    private Timer shakeReminderTimer = null;

	protected GameView(ccColor4B color)
	{
		super(color);
        this.setIsTouchEnabled(true);
        EventBus.getInstance().addGameEventListener(this);
        winSize = CCDirector.sharedDirector().winSize();

        //initialize the labels
		scoreLabel = CCLabel.makeLabel("Score: 0" , "DroidSans", 35);
		wordLabel = CCLabel.makeLabel("Spell Words!" , "DroidSans", 43);

        //set positions, colors
		scoreLabel.setColor(ccColor3B.ccWHITE);
        wordLabel.setColor(ccColor3B.ccWHITE);

		scoreLabel.setPosition((winSize.getWidth() / 2) , 32);
        wordLabel.setPosition((winSize.getWidth() / 2), winSize.getHeight() - 35);

        //add to screen
		addChild(scoreLabel);
        addChild(wordLabel);

		// Handle sound  / uncomment to do sound
		//Context context = CCDirector.sharedDirector().getActivity();
		//SoundEngine.sharedEngine().preloadEffect(context, R.raw.pew_pew_lei);
		//SoundEngine.sharedEngine().playSound(context, R.raw.background_music_aac, true);

		this.schedule("update");//update the frame events
        this.schedule("updateInput",.1f);//prevent input from broadcasting too much and chugging the system

        //add the background
        CCSprite darkBackground = new CCSprite(BACKGROUND_IMAGE);
        addChild(darkBackground);
        darkBackground.setScaleY(2f);
        darkBackground.setPosition(darkBackground.getTextureRect().size.width / 2f,darkBackground.getTextureRect().size.height * .5f);
	}

    public void notify(IGameEvent event)
    {
        switch (event.getType())
        {
            case GameEvent.SPRITE_WAS_CREATED_EVENT :
                //add a new letter to the scene when it gets created
                SpriteCreatedEvent spriteCreatedEvent = (SpriteCreatedEvent)event;
                addChild(spriteCreatedEvent.getSprite().getSprite());
                spriteCreatedEvent.getSprite().setIsAddedToScene(true);
                //make sure the labels are always on top
                this.reorderChild(scoreLabel, this.children_.size()-2);
                this.reorderChild(wordLabel, this.children_.size() - 2);
                break;
            case GameEvent.SPRITE_WAS_DESTROYED_EVENT:
                //remove a new letter to the scene when it gets created
                SpriteWasDestroyedEvent spriteWasDestroyedEvent = (SpriteWasDestroyedEvent)event;
                removeChild(spriteWasDestroyedEvent.getSprite().getSprite(),true);
                spriteWasDestroyedEvent.getSprite().setIsAddedToScene(false);
                break;
            case GameEvent.POINTS_UPDATED_EVENT:
                //update the points
                PointsUpdatedEvent pointsUpdatedEvent = (PointsUpdatedEvent)event;
                double points = pointsUpdatedEvent.getTotalPoints();
                NumberFormat formatter = new DecimalFormat("###,###,###.##");
                scoreLabel.setString("SCORE: " + formatter.format(points));
                break;
            case GameEvent.WORD_UPDATED_EVENT:
                //update the word
                UpdateWordEvent updateWordEvent = (UpdateWordEvent)event;
                wordLabel.setString(updateWordEvent.getWord().toUpperCase());
                break;
            case GameEvent.WORD_FOUND_EVENT:
                wordLabel.setString("-");
                resetShakeTimer();
                break;
            case GameEvent.NOT_A_WORD_EVENT:
                wordLabel.setString("(not a word)");
                break;
            case GameEvent.GAME_LOST_EVENT:
                destroy();
                break;
            case GameEvent.SHAKE_EVENT:
                resetShakeTimer();
                break;
        }
    }

    //creates a static game_activity_layout scene
	public static CCScene getSceneInstance()
	{
        //create the scene
        sceneInstance = CCScene.node();
        CCColorLayer layer = new GameView(ccColor4B.ccc4(0, 0, 0, 255));
        sceneInstance.addChild(layer);
		return sceneInstance;
	}

	
	@Override
	public boolean ccTouchesEnded(MotionEvent event)
	{
        //broadcast the touch
		CGPoint location = CCDirector.sharedDirector().convertToGL(CGPoint.ccp(event.getX(), event.getY()));
        EventBus.getInstance().broadcastGameEvent(new TouchEndEvent(this, location));
        isMoving = false;
		return true;
	}

    @Override
    public  boolean  ccTouchesBegan (MotionEvent event)
	{
        //broadcast the touch
		CGPoint location = CCDirector.sharedDirector().convertToGL(CGPoint.ccp(event.getX(), event.getY()));
        EventBus.getInstance().broadcastGameEvent(new TouchBeganEvent(this, location));

        return true;
    }

    @Override
    public  boolean  ccTouchesMoved (MotionEvent event)
	{
        //broadcast the touch
        isMoving = true;
        fingerPosition = CCDirector.sharedDirector().convertToGL(CGPoint.ccp(event.getX(), event.getY()));
        return true;
    }

    //non game_activity_layout logic shit
	public void update(float dt)
	{
        //broadcast the update
        EventBus.getInstance().broadcastGameEvent(new GameUpdateEvent(this, sceneInstance));
	}

    public void updateInput(float dt)
    {
         if(isMoving)
         {
             //only update at a restricted interval
              EventBus.getInstance().broadcastGameEvent(new TouchMovedEvent(this, fingerPosition));
         }
    }

    public boolean getIsDestroyed()
    {
        return isDestroyed;
    }

    private void resetShakeTimer()
    {
        //remind the user to shake if they get stuck
        if(shakeReminderTimer != null)shakeReminderTimer.cancel();
        shakeReminderTimer = new Timer();

        shakeReminderTimer.schedule(new TimerTask()
        {
            @Override
            public void run()
            {
               wordLabel.setString("If stuck, shake!");
            }

        }, SHAKE_REMINDER_TIMER);
    }

    public void destroy()
    {
		this.unschedule("update");//update the frame events
        this.unschedule("updateInput");//prevent input from broadcasting too much and chugging the system
        this.removeAllChildren(true);
        this.sceneInstance.removeAllChildren(true);
        this.sceneInstance.cleanup();
        isDestroyed=true;
        this.stopAllActions();
        CCScene.node().cleanup();
        this.cleanup();
        EventBus.getInstance().unsubscribe(this);
    }
}
