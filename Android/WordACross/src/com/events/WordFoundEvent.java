package com.events;

import com.models.LetterModel;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 9:33 AM
 */
public class WordFoundEvent extends GameEvent
{
    private ArrayList<LetterModel> letters;
    private String word;

    //fired when a word was successfully built in the dictionary
    //leads to score being incremented etc, a number of changes
    public WordFoundEvent(Object source, ArrayList<LetterModel> _letters, String _word)
    {
        super(source, WORD_FOUND_EVENT);
        letters = _letters;
        word = _word;
    }
    public ArrayList<LetterModel> getLetters() {
        return letters;
    }

    public void setLetters(ArrayList<LetterModel> letters) {
        this.letters = letters;
    }

    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word;
    }
}
