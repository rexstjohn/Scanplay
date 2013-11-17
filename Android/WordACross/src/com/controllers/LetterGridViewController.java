package com.controllers;

import com.events.*;
import com.glue.EventBus;
import com.models.*;
import com.views.GameView;
import org.cocos2d.nodes.CCSpriteSheet;

import java.text.BreakIterator;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Timer;
import java.util.TimerTask;

//manages the letter columns (aka the letter grid)
public class LetterGridViewController extends GameController
{

    //models
    private LetterGridModel model;
    private LetterSelectionModel letterSelectionModel = null;//local copy to keep track of the selection model

    //sub controllers
    private ArrayList<LetterColumnViewController> columnViewControllers;

    //timer to make sure we dont let people shake things too often
    private boolean canShake = false;
    private Timer shakeTimer;

    public LetterGridViewController(LetterGridModel _model)
    {
        super();
        model = _model;
        columnViewControllers = new ArrayList<LetterColumnViewController>();
    }

    @Override
    public void notify(IGameEvent event)
    {
        switch (event.getType())
        {
            case  GameEvent.START_GAME_EVENT:
                createNewGameGrid();
                break;
            case GameEvent.LETTER_TOUCHED_EVENT:
               LetterTouchedEvent letterTouchedEvent = (LetterTouchedEvent)event;

                //check and see if the letter is next to another selected letter
               handleLetterTouch(letterTouchedEvent.getSelectedLetter());
               break;
            case GameEvent.LETTER_SELECTION_CHANGED_EVENT:
                //keeps us current with the state of the letter selection via injection
                LetterSelectionChangedEvent letterSelectionChangedEvent = (LetterSelectionChangedEvent)event;
                letterSelectionModel = letterSelectionChangedEvent.getSelection();
                break;
            case GameEvent.SHAKE_EVENT:

                if(canShake)
                {
                    model.clearAllLetters();
                    canShake = false;

                    shakeTimer = new Timer();
                    shakeTimer.schedule(new TimerTask()
                    {
                        @Override
                        public void run()
                        {
                          canShake=true;
                        }
                    },5000);
                }
                break;
        }
    }

    //determines the logic about whether a letter can be selected or not
    //if so, selects it and tells the world it has been selected
    private void handleLetterTouch(LetterModel _letter)
    {
      //if the letter is already selected, ignore it
      if(_letter.getSelected())return;

      //if this is the first letter, select it and quit
      if(model.getSelectedCount() == 0)
      {
          _letter.setSelected(true);
          EventBus.getInstance().broadcastGameEvent(new LetterSelectedEvent(this,_letter));
          return;
      }

        //check and see if the last selected letter is next to this letter
       if(letterSelectionModel.getLastSelection() != null)
       {
          LetterModel lastSelection = letterSelectionModel.getLastSelection();

           if(lastSelection == _letter)return;

          float dx = _letter.getX() - lastSelection.getX();
          float dy = _letter.getY() - lastSelection.getY();
          double distance = Math.sqrt(dx*dx + dy*dy);

           //will only select a letter that is close to the last selected letter
          if(distance <= LetterModel.LETTER_WIDTH * 1.5)
          {
              _letter.setSelected(true);
              EventBus.getInstance().broadcastGameEvent(new LetterSelectedEvent(this,_letter));
          }
       }
        else
            return;

    }

    @Override
    public void destroy()
    {
        model.destroy();
        model=null;
        letterSelectionModel=null;
        columnViewControllers=null;
        super.destroy();
    }

    //create a new grid of models and view controllers
    private void createNewGameGrid()
    {
        //create a new grid
        float xOffset = (LetterModel.LETTER_WIDTH /2);//gap on the left side
        float yOffset = LetterGridModel.LETTER_Y_OFFSET;        // space between the bottom and the first letter

        boolean staggerColumn = false;//do we stagger this column
        float floorY = yOffset;   //staggered y value
        int columnLetterCount = LetterGridModel.COLUMN_LETTER_COUNT;

        //create the columns
        for(int i = 0; i < (LetterGridModel.COLUMN_COUNT ); i++)
        {
            //stagger the y values of every other column
            //by one half letter height
             if(staggerColumn)
             {
                 floorY -= LetterModel.LETTER_HEIGHT / 2;
                 staggerColumn = false;
             }
            else
             {
                 floorY = yOffset;
                 staggerColumn = true;
             }

             //create the new letter column
             LetterColumnModel newLetterColumn = new LetterColumnModel(model.getLetterSprites(),(i * LetterModel.LETTER_WIDTH) + xOffset, floorY + yOffset,columnLetterCount);
             LetterColumnViewController letterColumnViewController =  new LetterColumnViewController(newLetterColumn);

             //create a new column
             model.addLetterColumnModel(newLetterColumn);

            //create a new controller to manage the column
            columnViewControllers.add(letterColumnViewController);

            //start the tween animation
            letterColumnViewController.doColumnDropAnimation();
        }

        canShake = true;
    }
}
