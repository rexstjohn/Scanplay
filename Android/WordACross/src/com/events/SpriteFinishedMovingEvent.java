package com.events;

import com.models.GameSpriteModel;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/25/11
 * Time: 8:33 PM
 */
public class SpriteFinishedMovingEvent extends GameEvent
{
    private GameSpriteModel sprite;

    //fired when a game_activity_layout was lost
    public SpriteFinishedMovingEvent(Object source, GameSpriteModel _sprite)
    {
        super(source, SPRITE_FINISHED_MOVING_EVENT);
        sprite = _sprite;

    }

    public GameSpriteModel getSprite() {
        return sprite;
    }
}
