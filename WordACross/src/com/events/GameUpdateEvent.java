package com.events;

import org.cocos2d.layers.CCScene;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 9:40 AM
 */
public class GameUpdateEvent extends GameEvent
{
    private CCScene scene;

    //fired when a game_activity_layout screen update occurs
    public GameUpdateEvent(Object source, CCScene _scene)
    {
        super(source, GAME_UPDATE_EVENT);
        scene = _scene;
    }

    public CCScene getScene() {
        return scene;
    }
}
