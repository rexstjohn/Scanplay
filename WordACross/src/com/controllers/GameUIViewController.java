package com.controllers;

import com.events.*;
import com.glue.EventBus;
import com.models.GameModel;
import com.models.GameSpriteModel;
import com.models.GameUIModel;
import com.models.LetterModel;
import com.utils.Alphabet;
import com.utils.GameDialogue;
import com.utils.GameDictionaryHashMap;
import org.cocos2d.types.CGPoint;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.atomic.AtomicLongArray;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 12:36 AM
 *
 * Responsible for controlling the UI including score, level, word displays
 */
public class GameUIViewController extends GameController
{
    private  GameUIModel model;
    private  Timer gameTickTimer = null;//adds red blocks on update

    public GameUIViewController(GameUIModel _model)
    {
        super();
        model = _model;
    }

    @Override
    public void notify(IGameEvent event)
    {
        switch (event.getType())
        {
            case GameEvent.WORD_FOUND_EVENT:
                //update the score whenever a word has been found
                //add levels, points etc
                //subtract points for a bad word
                WordFoundEvent  wordFoundEvent = (WordFoundEvent)event;

                if(GameDictionaryHashMap.contains(wordFoundEvent.getWord()))
                {
                    model.setPoints(model.getPoints() + Alphabet.calculateWordValue(wordFoundEvent.getWord()));
                    EventBus.getInstance().broadcastGameEvent(new PointsUpdatedEvent(this, model.getPoints()));
                    updateGameDifficulty(wordFoundEvent.getLetters().size());//NOTE:only for blitz mode
                }
                else
                {
                    EventBus.getInstance().broadcastGameEvent(new NotAWordEvent(this));
                }

                break;
            case GameEvent.START_GAME_EVENT:
                if(model.getGameMode().equals("blitzMode"))
                    scheduleTick();
                break;
            case GameEvent.GAME_PAUSED_EVENT:
                if(model.getGameMode().equals("blitzMode"))
                    gameTickTimer.cancel();
                break;
            case GameEvent.GAME_RESUMED_EVENT:
                if(model.getGameMode().equals("blitzMode"))
                    scheduleTick();
                break;
        }
    }

    //increases the difficulty of the game in blitz mode as points are earned
    private void updateGameDifficulty(int letterCount)
    {
        int currentLevel = model.getLevel();
        model.removeRedBlocks(letterCount);//remove a red block

        if(model.getPoints() > (model.SPEED_INCREASE * currentLevel))
            currentLevel++;

        model.setLevel(currentLevel);
    }

    //start the tick timer on game start
    private void scheduleTick()
    {
        if(gameTickTimer == null)
            gameTickTimer = new Timer();

        gameTickTimer.schedule(new TimerTask()
        {
            @Override
            public void run()
            {
                if(model==null) return;
                if(model.getRedBlocks().size() == 9)
                {
                    EventBus.getInstance().broadcastGameEvent(new GameLostEvent(GameUIViewController.this, model.getPoints()));
                }
                else
                {
                    EventBus.getInstance().broadcastGameEvent(new GameTickEvent(this));
                    model.addRedBlock();
                    model.setTickInterval(model.getTickInterval() - (model.getLevel() * model.getTickCount()));
                    scheduleTick();
                }
            }

        }, model.getTickInterval());
    }

    @Override
    public void destroy()
    {
        if(gameTickTimer!=null)gameTickTimer.cancel();
        gameTickTimer = null;
        model=null;
        super.destroy();
    }
}
