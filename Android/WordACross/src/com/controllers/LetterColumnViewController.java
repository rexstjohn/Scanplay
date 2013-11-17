package com.controllers;

import android.text.format.Time;
import com.events.*;
import com.models.*;
import org.cocos2d.nodes.CCSprite;
import org.cocos2d.types.CGPoint;
import org.cocos2d.types.CGRect;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.Timer;
import java.util.TimerTask;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 6:08 PM
 *
 * Manages the behavior of a column of letters
 */
public class LetterColumnViewController extends GameController
{
    //models
    private LetterColumnModel model;
    private Timer dropTimer;

    public LetterColumnViewController(LetterColumnModel _model)
    {
        super();
        model = _model;
    }

     @Override
    public void notify(IGameEvent event)
    {
        switch (event.getType())
        {
            case  GameEvent.SPRITE_WAS_DESTROYED_EVENT:
                //remove a letter from this column if the letter is contained here
                //happens when a letter gets destroyed
                SpriteWasDestroyedEvent spriteWasDestroyedEvent = (SpriteWasDestroyedEvent)event;

                  if(!(spriteWasDestroyedEvent.getSprite() instanceof  LetterModel)) return;
                 if(!model.contains((LetterModel)spriteWasDestroyedEvent.getSprite())) return;

                //wake up the column to make it move
                model.removeLetter((LetterModel)spriteWasDestroyedEvent.getSprite());//remove the letter to stop it from getting in the way
                //replace the missing letter with a new letter
                model.addLetterAtPosition(CGPoint.make(model.getXPosition(), model.getHighestLetterModel().getY() + (LetterModel.LETTER_HEIGHT * 1.5f)));
                model.resetLetterIndices();//reset the letter indicies to account for the missing letter
                model.setState(LetterColumnModel.ACTIVE_STATE); //wake up the letters so they will begin moving
                break;
            case GameEvent.GAME_UPDATE_EVENT:
                //move the letters and do collissions if the model is active
                //to save CPU, the letters go to sleep when they arent moving
                //so we dont burn cycles calculating unneeded collissions
                if(model.getState() == GameModel.ACTIVE_STATE)
                    moveLetters();
                break;
        }
    }

    @Override
    public void destroy()
    {
        dropTimer = null;
        model=null;
        super.destroy();
    }

    //moves the letters in the column until all the letters are sleeping
    private void moveLetters()
	{
         ArrayList<LetterModel>  _letters = model.getLetters();
        int sleepingCount = 0;

        //check for letter collissions
		for (LetterModel _letter : _letters)
		{
            //dont bother if the letter is asleep (helps optimize speed)
            if(_letter.getState() == GameModel.SLEEPING_STATE || hasCollission(_letter) || _letter.getY() <=  model.getYPosition())
            {
                sleepingCount++;

                //dont do the collission checking if all the letters are sleeping
                if(sleepingCount == _letters.size())
                    model.setState(GameModel.SLEEPING_STATE);

                continue;
            }

              //move the letter
            _letter.setPosition(CGPoint.make(_letter.getPosition().x,_letter.getPosition().y - LetterModel.LETTER_VELOCITY));
		}
    }

    //determins if a letter is hitting another letter below it only
    //sleeps the letter if it has a hit
    private boolean hasCollission(LetterModel _letter)
	{
        ArrayList<LetterModel>  _letters = model.getLetters();

        CGRect _letterRect = CGRect.make(_letter.getPosition().x,
                _letter.getPosition().y,
                _letter.getWidth(),
                _letter.getHeight());

        //check for letter collissions
		for (LetterModel _checkLetter : _letters)
		{
            //skip if its a self collission
            if(_checkLetter == _letter)continue;
            if(_checkLetter.getIsDestroyed())continue;;
            if(_checkLetter.getIsBeingRemoved())continue;
            if(_checkLetter.getY() > _letter.getY())continue;//we dont care about letters above us, only below

            CGRect _letterARect = CGRect.make(_checkLetter.getPosition().x,
                    _checkLetter.getPosition().y,
                    _checkLetter.getWidth(),
                    _checkLetter.getHeight());

            if (CGRect.intersects(_letterRect, _letterARect))
            {
                //snap the letter to be outside of the other letter
                _letter.setPosition(CGPoint.make(_letter.getPosition().x, _checkLetter.getPosition().y + _letterARect.size.getHeight()));
                _letter.setState(GameModel.SLEEPING_STATE);
                return true;
            }
		}

        return false;
	}

    //drops the column to its base point from its high points
    public void doColumnDropAnimation()
    {
        dropTimer = new Timer();
        float dropHeight = model.LETTER_DROP_HEIGHT;//how far the letters drop at the start of the game_activity_layout
        model.setState(GameModel.ACTIVE_STATE);//wake up the column and all the letters

        //put all the letters off the screen
        Iterator _letters = ((ArrayList<GameSpriteModel>)model.getLetters().clone()).iterator();
        LetterModel letter;

        while( _letters.hasNext() )
        {
            //move the letters off screen and hen drop them back in place
            letter =  ((LetterModel) _letters.next() );
            letter.setVisible(false);
        }

        dropTimer.schedule(new ColumnDropTask(), (int)dropHeight);
    }
     //drop the column after some delay
    //happens only once at the start of the game_activity_layout
    class ColumnDropTask extends TimerTask
    {
        public void run()
        {
            Iterator _letters = ((ArrayList<GameSpriteModel>)model.getLetters().clone()).iterator();
            LetterModel letter;
            CGPoint endPoint;//where the letter needs to end up
            float dropHeight = 0;//(float) 10 * LetterModel.LETTER_HEIGHT;
            int spacing = 0;
            int count = 0;

            while( _letters.hasNext() )
            {
                //move the letters off screen and hen drop them back in place
                letter =  ((LetterModel) _letters.next() );
                endPoint = letter.getPosition();//store this
                letter.setVisible(true);
                letter.setPosition(CGPoint.make(endPoint.x, endPoint.y + dropHeight + (count * spacing)));
                count ++;
            }

            dropTimer.cancel(); //Terminate the timer thread
        }
    }
}
