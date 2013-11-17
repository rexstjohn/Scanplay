package com.events;


/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/27/11
 * Time: 10:06 PM
 */
public class UpdateWordEvent extends GameEvent
{
    private String word;

   public UpdateWordEvent(Object sender, String _word)
   {
       super(sender, WORD_UPDATED_EVENT);
       word = _word;
   }

    public String getWord() {
        return word;
    }
}
