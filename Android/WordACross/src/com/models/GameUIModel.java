package com.models;

import com.events.SpriteCreatedEvent;
import com.events.SpriteWasDestroyedEvent;
import com.glue.EventBus;
import org.cocos2d.nodes.CCSprite;
import org.cocos2d.types.CGPoint;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 1:00 AM
 *
 * represents the state of the game_activity_layout ui
 */
public class GameUIModel extends GameModel
{
    public static final int RED_BLOCK_WIDTH = 35;
    public static final int RED_BLOCK_HEIGHT = 50;
    public static final int RED_BLOCK_PADDING_RIGHT = 5;
    public static final String RED_BLOCK_SRC = "game_red_block.png";
    public static final int DEFAULT_TICK_INTERVAL = 5000;
    public static final int SPEED_INCREASE = 750;

    LetterSelectionModel selectionModel;//word at the top

    //list of red bocks
    private ArrayList<GameSpriteModel> redBlocks;

    private int points;//number of points
    private int level;//levels
    private int tickInterval;
    private String gameMode;
    private int tickCount;

    public GameUIModel(String _gameMode)
    {
        super();
        gameMode = _gameMode;
        points = 0;
        level = 1;
        tickCount = 0;
        tickInterval =  DEFAULT_TICK_INTERVAL;
        redBlocks = new ArrayList<GameSpriteModel>();
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public ArrayList<GameSpriteModel> getRedBlocks() {
        return redBlocks;
    }

    public void setRedBlocks(ArrayList<GameSpriteModel> redBlocks) {
        this.redBlocks = redBlocks;
    }

    public void addRedBlock()
    {
        GameSpriteModel redBlock = new GameSpriteModel(RED_BLOCK_WIDTH,RED_BLOCK_HEIGHT,RED_BLOCK_SRC);
        CGPoint newBlockPos = CGPoint.make((redBlocks.size()*RED_BLOCK_WIDTH) + (RED_BLOCK_WIDTH /2) + RED_BLOCK_PADDING_RIGHT, (RED_BLOCK_HEIGHT / 2) + 5);
        redBlock.setPosition(newBlockPos);
        redBlocks.add(redBlock);
        EventBus.getInstance().broadcastGameEvent(new SpriteCreatedEvent(this,redBlock));
    }

    public void removeRedBlocks(int numberToRemove)
    {
        while(redBlocks.size() > 0 && numberToRemove > 0)
        {
            numberToRemove --;
            GameSpriteModel redBlock = redBlocks.get(redBlocks.size()-1);
            redBlocks.remove(redBlock);
            redBlock.destroy();
        }
    }

    @Override
    public void destroy()
    {
        redBlocks.removeAll(redBlocks);
        redBlocks = null;
        selectionModel = null;
        super.destroy();
    }

    public int getTickInterval()
    {
        return tickInterval;
    }

    public void setTickInterval(int tickInterval) {
        this.tickInterval = tickInterval;
    }

    public String getGameMode() {
        return gameMode;
    }

    public int getTickCount() {
        return tickCount;
    }
}
