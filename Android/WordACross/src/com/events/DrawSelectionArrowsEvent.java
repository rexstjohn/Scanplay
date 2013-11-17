package com.events;

import com.models.LetterModel;
import com.models.SelectionArrowModel;

import java.lang.reflect.Array;
import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 3:12 PM
 */
public class DrawSelectionArrowsEvent extends  GameEvent
{
    private ArrayList<LetterModel> selection;//list of letters in the selection to draw
    private ArrayList<SelectionArrowModel> arrows;//list of arrows in the selection to draw

    //fired when its time to update the selection arrows
    public DrawSelectionArrowsEvent(Object source, ArrayList<LetterModel> _selection, ArrayList<SelectionArrowModel> _arrows)
    {
        super(source, DRAW_SELECTION_ARROWS_EVENT);
        selection = _selection;
        arrows = _arrows;
    }

    public ArrayList<LetterModel> getSelection()
    {
        return selection;
    }

    public ArrayList<SelectionArrowModel> getArrows()
    {
        return arrows;
    }
}
