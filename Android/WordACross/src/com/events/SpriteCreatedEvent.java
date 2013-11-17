package com.events;

import com.models.GameSpriteModel;
import com.models.LetterModel;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 11:14 AM
 */
public class SpriteCreatedEvent extends  GameEvent
{
    private GameSpriteModel sprite;

    //fired when a game_activity_layout was lost
    public SpriteCreatedEvent(Object source, GameSpriteModel _sprite)
    {
        super(source, SPRITE_WAS_CREATED_EVENT);
        sprite = _sprite;

    }

    public GameSpriteModel getSprite() {
        return sprite;
    }
}
