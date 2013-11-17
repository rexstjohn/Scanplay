package com.models;

import android.util.Log;
import com.events.DrawSelectionArrowsEvent;
import com.glue.EventBus;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 12:13 AM
 *
 * managed the state of the letter selection
 */
public class LetterSelectionModel extends GameModel
{
    private ArrayList<LetterModel> selection;//selected letters
    private ArrayList<SelectionArrowModel> arrows;//selected letters

    public LetterSelectionModel()
    {
         super();
        selection = new ArrayList<LetterModel>();
        arrows = new ArrayList<SelectionArrowModel>();
    }

    @Override
    public void destroy()
    {
        SelectionArrowModel[] _selectionArrowModel = arrows.toArray(new SelectionArrowModel[arrows.size()]);

        for(SelectionArrowModel selectionArrowModel : _selectionArrowModel)
        {
            selectionArrowModel.destroy();
            selectionArrowModel=null;
        }

        selection.removeAll(selection);
        selection = null;
        arrows.removeAll(arrows);
        arrows=null;
        super.destroy();
    }

    public void addLetter(LetterModel _letter)
    {
        //make sure not to add the letter twice
        if(selection.contains(_letter))return;
        //this is the first letter in a new chain
        if(selection.size() == 0)
            _letter.setIsFirstSelection(true);

        //add the letter to the selection
        selection.add(_letter);

        //ONLY DO THIS if we have more than one letters
        if(selection.size() > 1)
        {
            //create a new arrow pointer using the last pointer in the stack
            SelectionArrowModel newArrow = new SelectionArrowModel((LetterModel)selection.get(selection.indexOf(_letter)-1), _letter);
            arrows.add(newArrow);

            //tell the world to update the arrow list
            EventBus.getInstance().broadcastGameEvent(new DrawSelectionArrowsEvent(this,selection,arrows));
        }
    }

    public void removeLetter(LetterModel _letter)
    {
        selection.remove(_letter);
    }

    public void clearArrows()
    {
        arrows.removeAll(arrows);
    }

    public ArrayList<SelectionArrowModel> getArrows()
    {
        return arrows;
    }

    public boolean contains(LetterModel _letter)
    {
        return selection.contains(_letter);
    }

    public int length()
    {
        return  selection.size();
    }

    public LetterModel getLastSelection()
    {
        if(selection.size() > 0)
          return selection.get(selection.size()-1);
        else
            return  null;

    }

    public ArrayList<LetterModel> getSelection()
    {
        return selection;
    }

    public String getWord()
    {
        String word = "";

        for(LetterModel letter : selection)
        {
            word = word + letter.getLetterType();
        }

        return  word;
    }

    public void clearLetters()
    {
        selection.removeAll(selection);
    }
}
