package com.models;

import android.util.Log;
import com.events.SpriteCreatedEvent;
import com.events.SpriteWasDestroyedEvent;
import com.glue.EventBus;
import com.glue.IGameEventListener;
import com.utils.Alphabet;
import org.cocos2d.nodes.CCSprite;
import org.cocos2d.nodes.CCSpriteFrame;
import org.cocos2d.types.CGPoint;
import com.utils.NextLetterSelectionUtility;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Random;

//represents the state of a letter column


public class LetterColumnModel  extends GameModel
{
    public static final int LETTER_DROP_HEIGHT = 500;

    //column of letters
    private ArrayList<LetterModel> letters;

    //graphics for letters
    private ArrayList<CCSpriteFrame> letterFrames;

    //bottom Y value which represents the floor of this column
    private float yPosition;
    private float xPosition;

    public LetterColumnModel(ArrayList<CCSpriteFrame>_letterFrames, float _xPosition, float _yPosition, int _letterCount)
    {
        super();
        yPosition = _yPosition;
        xPosition = _xPosition;
        letters = new ArrayList<LetterModel>();
        letterFrames = _letterFrames;
        state = SLEEPING_STATE;

        //add all the letters
        for(int i =0; i < _letterCount; i++)
        {
            addLetterAtPosition(CGPoint.make(xPosition, (i * LetterModel.LETTER_HEIGHT) + yPosition));
        }
    }

    @Override
    public void destroy()
    {
        LetterModel[] _letters = letters.toArray(new LetterModel[letters.size()]);

        for(LetterModel letter : _letters)
        {
            letter.destroy();
            letter = null;
        }

        letters.removeAll(letters);
        letterFrames.removeAll(letterFrames);
        super.destroy();
    }


    public float getXPosition()
    {
        return xPosition;
    }

    public float getYPosition()
    {
        return yPosition;
    }

    public ArrayList<LetterModel> getLetters()
    {
        return letters;

    }

    @Override
    public void setState(int _state)
    {
        super.setState(_state);

        //awaken all the letters in the column if we are waking up the column
        if(_state == this.ACTIVE_STATE)
            awakenLetters();
        else if(_state == this.SLEEPING_STATE)
            sleepLetters();
    }

    //sets all the letters to awake state
    private void awakenLetters()
    {
        for (LetterModel _letter:letters)
		{
            _letter.setState(GameModel.ACTIVE_STATE);
		}
    }

    //sets all the letters to sleep state
    private void sleepLetters()
    {
        for (LetterModel _letter:letters)
		{
            _letter.setState(GameModel.SLEEPING_STATE);
		}
    }

    //reset the letter indices
    public void resetLetterIndices()
    {
        int count = 0;

        for (LetterModel _letter:letters)
		{
            _letter.setRowIndex(count);
            count++;
		}
    }

    public boolean contains(LetterModel letterModel)
    {
        return letters.contains(letterModel);
    }

    //add a letter at a given position
    public  void  addLetterAtPosition(CGPoint _position)
    {
        //use a random letter
        int index = NextLetterSelectionUtility.getRandomLetterIndex();

        LetterModel newLetter = new LetterModel(Alphabet.chars.get(index).charAt(0),letterFrames.get(index), letters.size());
        newLetter.setPosition(_position);
        letters.add(newLetter);

        //inform the world a letter has been created
        EventBus.getInstance().broadcastGameEvent(new SpriteCreatedEvent(this, newLetter));
    }

    //remove a letter
    public void removeLetter(LetterModel _letter)
    {
        letters.remove(_letter);
    }

    //gets only the chars for the column
    public ArrayList getLetterCharacters()
    {
        ArrayList characters = new ArrayList();

        for(LetterModel letter : letters)
        {
            characters.add(letter.getLetterType());
        }

        return characters;
    }

    //returns the letter model with the greatest y value
    public LetterModel getHighestLetterModel()
    {
        LetterModel topLetter = letters.get(0);

        for(LetterModel _letterModel : letters)
        {
            if(_letterModel.getY() > topLetter.getY())
                topLetter = _letterModel;
        }

        return topLetter;
    }

    //blow the letters up in a random fashion
    public void clearAllLetters()
    {
         for(LetterModel letterModel : letters)
         {
             letterModel.animateOutAndDestroyRandomly();
         }
    }
}
