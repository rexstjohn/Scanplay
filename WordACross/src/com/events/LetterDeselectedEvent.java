package com.events;

import com.models.LetterModel;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 9:49 AM
 */
public class LetterDeselectedEvent extends GameEvent
{
    private LetterModel deselectedLetter;

    //fired when a letter has been selected
    public LetterDeselectedEvent(Object source, LetterModel _deselectedLetter)
    {
        super(source, LETTER_DESELECTED_EVENT);
        this.deselectedLetter = _deselectedLetter;
    }

    public LetterModel getSelectedLetter() {
        return deselectedLetter;
    }

    public void setSelectedLetter(LetterModel selectedLetter) {
        this.deselectedLetter = selectedLetter;
    }
}
