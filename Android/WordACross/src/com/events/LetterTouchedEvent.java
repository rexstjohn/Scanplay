package com.events;

import com.models.LetterModel;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 8/2/11
 * Time: 9:38 PM
 */
public class LetterTouchedEvent extends GameEvent
{
    private LetterModel touchedLetter;

    //fired when a letter has been touched
    public LetterTouchedEvent(Object source, LetterModel _touchedLetter)
    {
        super(source,LETTER_TOUCHED_EVENT);
        this.touchedLetter = _touchedLetter;
    }

    public LetterModel getSelectedLetter() {
        return touchedLetter;
    }

    public void setSelectedLetter(LetterModel selectedLetter) {
        this.touchedLetter = selectedLetter;
    }
}
