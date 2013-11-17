package com.events;

import java.util.EventObject;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 9:13 AM
 */
public class GameEvent extends EventObject implements IGameEvent
{
      //event types
      public static final int GAME_LOST_EVENT = 0;
      public static final int GAME_UPDATE_EVENT = 1;
      public static final int LETTER_DESELECTED_EVENT = 2;
      public static final int LETTER_SELECTED_EVENT = 3;
      public static final int LEVEL_UPDATED_EVENT = 4;
      public static final int START_GAME_EVENT = 5;
      public static final int TOUCH_BEGAN_EVENT = 6;
      public static final int TOUCH_ENDED_EVENT = 7;
      public static final int TOUCH_MOVED_EVENT = 8;
      public static final int WORD_FOUND_EVENT = 9;
      public static final int QUIT_GAME_EVENT = 10;
      public static final int SPRITE_WAS_CREATED_EVENT = 11;//sprite was created in the model and scene
      public static final int SPRITE_WAS_DESTROYED_EVENT = 12;//sprite was removed from the model /scene
      public static final int DRAW_SELECTION_ARROWS_EVENT = 13;//tell the view to draw the arrows for a given selection
      public static final int SPRITE_FINISHED_MOVING_EVENT = 14;//sprite has finished moving
      public static final int POINTS_UPDATED_EVENT = 15;//fired when points are scored
      public static final int WORD_UPDATED_EVENT = 16;//fired when points are scored
      public static final int LETTER_TOUCHED_EVENT = 17;//fired when a letter gets touched
      public static final int LETTER_SELECTION_CHANGED_EVENT = 18;//fired when a letter gets touched
      public static final int NOT_A_WORD_EVENT = 19;//fired when a non word is formed
      public static final int GAME_TICK_EVENT = 20;//fired when a game "tick" occurs
      public static final int SHAKE_EVENT = 21;//fired when a game "tick" occurs
      public static final int GAME_PAUSED_EVENT = 22;//fired when a game "tick" occurs
      public static final int GAME_RESUMED_EVENT = 23;//fired when a game "tick" occurs

      private int type;

      public GameEvent(Object source, int type)
      {
         super( source );
         this.type = type;
      }

    public int getType(){return type;}
    public int setType(){return type;}

}
