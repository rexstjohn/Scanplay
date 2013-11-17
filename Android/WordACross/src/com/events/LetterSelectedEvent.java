package com.events;

import com.models.LetterModel;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 9:47 AM
 */
public class LetterSelectedEvent extends GameEvent
{
    private LetterModel selectedLetter;

    //fired when a letter has been selected
    public LetterSelectedEvent(Object source, LetterModel _selectedLetter)
    {
        super(source,LETTER_SELECTED_EVENT);
        this.selectedLetter = _selectedLetter;
    }

    public LetterModel getSelectedLetter() {
        return selectedLetter;
    }

    public void setSelectedLetter(LetterModel selectedLetter) {
        this.selectedLetter = selectedLetter;
    }
}
