package com.events;

import com.models.GameSpriteModel;
import com.models.LetterModel;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 11:23 AM
 */
public class SpriteWasDestroyedEvent extends  GameEvent
{
    private GameSpriteModel sprite;

    //fired when a game_activity_layout was lost
    public SpriteWasDestroyedEvent(Object source, GameSpriteModel _sprite)
    {
        super(source, SPRITE_WAS_DESTROYED_EVENT);
        sprite = _sprite;

    }

    public GameSpriteModel getSprite() {
        return sprite;
    }
}
