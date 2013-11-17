package com.events;

import com.models.LetterModel;
import com.models.LetterSelectionModel;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 8/2/11
 * Time: 9:52 PM
 */
public class LetterSelectionChangedEvent  extends GameEvent
{
    private LetterSelectionModel selectionModel;

    //fired when a letter selection has changed
    public LetterSelectionChangedEvent(Object source, LetterSelectionModel _selectionModel)
    {
        super(source,LETTER_SELECTION_CHANGED_EVENT);
        selectionModel = _selectionModel;
    }

    public LetterSelectionModel getSelection()
    {
        return  selectionModel;
    }

}
