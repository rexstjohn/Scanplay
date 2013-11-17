package com.controllers;

import com.events.*;
import com.glue.EventBus;
import com.models.*;
import com.utils.GameDictionaryHashMap;

import java.util.ArrayList;
import java.util.Iterator;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 3:01 PM
 *
 * Mantains the state of a letter selection currently in progress
 */
public class LetterSelectionViewController extends GameController
{
    private LetterSelectionModel model;

    public LetterSelectionViewController(LetterSelectionModel _model)
    {
        super();
        model = _model;
    }

    @Override
    public void destroy()
    {
        model = null;
        super.destroy();
    }

    @Override
    public void notify(IGameEvent event)
    {
        switch (event.getType())
        {
            case GameEvent.LETTER_SELECTED_EVENT:
               LetterSelectedEvent letterSelectedEvent = (LetterSelectedEvent)event;

                //break early if letter selection is a certain length
                if(model.length() == 6)
                {
                    clearAll();
                    EventBus.getInstance().broadcastGameEvent(new UpdateWordEvent(this, model.getWord()));
                    EventBus.getInstance().broadcastGameEvent(new LetterSelectionChangedEvent(this,model));
                    return;
                }

                if(!model.contains(letterSelectedEvent.getSelectedLetter()))
                {
                    model.addLetter(letterSelectedEvent.getSelectedLetter());
                    EventBus.getInstance().broadcastGameEvent(new UpdateWordEvent(this, model.getWord()));
                    EventBus.getInstance().broadcastGameEvent(new LetterSelectionChangedEvent(this,model));
                }
               break;
            case GameEvent.LETTER_DESELECTED_EVENT:
                //Note: this is not really used anymore, letters dont get deselected, the are just removed
               LetterDeselectedEvent letterDeselectedEvent = (LetterDeselectedEvent)event;
               //model.deselectAllLettersAbove(letterDeselectedEvent.getSelectedLetter());
               break;
            case GameEvent.DRAW_SELECTION_ARROWS_EVENT:
                //tells the game_activity_layout view how to draw the arrows connecting selected letters
                DrawSelectionArrowsEvent drawSelectionArrowsEvent = (DrawSelectionArrowsEvent)event;
                drawSelectionArrows(((DrawSelectionArrowsEvent) event).getArrows());
                break;
            case GameEvent.TOUCH_ENDED_EVENT:
                //when a user lifts their finger, the selection is nulled
                //clearAll();
                handleTouchEnded();
                break;
        }
    }

    private void handleTouchEnded()
    {
         //check if the word is in the dictionary
        EventBus.getInstance().broadcastGameEvent(new WordFoundEvent(this,model.getSelection(),model.getWord()));

        clearAll();
    }

    private void clearAll()
    {
        clearArrows();
        clearWord();
    }

    //draw the arrows on the stage if they arent already on the stage
    private void drawSelectionArrows(ArrayList<SelectionArrowModel> _arrows)
    {
        Iterator arrows = ((ArrayList<SelectionArrowModel>)_arrows.clone()).iterator();

        while( arrows.hasNext() )
        {
            //dont add the arrow if its already on the stage
            SelectionArrowModel arrow = ((SelectionArrowModel)arrows.next());

            //add the arrow to the scene if it isnt already
            if(!arrow.isAddedToScene())
                EventBus.getInstance().broadcastGameEvent(new SpriteCreatedEvent(this,arrow));
        }
    }

    //clear out the arrows
    private void clearArrows()
    {
        Iterator _arrows = ((ArrayList<GameSpriteModel>)model.getArrows().clone()).iterator();
        while( _arrows.hasNext() )
        {
            //animate the letters out
            SelectionArrowModel arrow =  ((SelectionArrowModel) _arrows.next() );
            arrow.destroy();
        }

        //clear the letters
        model.clearArrows();
    }

    //destroy the word
    private void clearWord()
    {
        Iterator _letters = ((ArrayList<GameSpriteModel>)model.getSelection().clone()).iterator();

        while( _letters.hasNext() )
        {
            //animate the letters out
            LetterModel letter =  ((LetterModel) _letters.next() );
            letter.animateOutAndDestroy();
        }

        //clear the letters
        model.clearLetters();
    }
}
