package com.controllers;

import com.events.*;
import com.glue.EventBus;
import com.models.GameUIModel;
import com.models.LetterGridModel;
import com.models.LetterSelectionModel;
import com.utils.Alphabet;
import com.utils.GameDictionaryHashMap;

import java.util.ArrayList;

/**
 * Created by IntelliJ IDEA.
 * User: ScanPlayGames
 * Date: 7/24/11
 * Time: 12:55 AM
 *
 * The main game_activity_layout view which launches all the sub views on the game_activity_layout screen
 */
public class GameViewController extends GameController
{
    //sub controllers
    private GameUIViewController  gameUIViewController;//handles the levels,score and progress meter
    private LetterGridViewController letterGridViewController;//handles the letter grid, interaction with letters
    private LetterSelectionViewController letterSelectionViewController;//handles the arrow selections

    //sub models
    private GameUIModel gameUIModel;
    private LetterGridModel letterGridModel;
    private LetterSelectionModel letterSelectionModel;

    //the game mode
    private String gameMode;

    public GameViewController(String _gameMode)
    {
        super();
        gameMode = _gameMode;
    }

    public void start()
    {
        //start game_activity_layout logic
        //create the models
        gameUIModel = new GameUIModel(gameMode);
        letterGridModel = new LetterGridModel();
        letterSelectionModel = new LetterSelectionModel();

        //create all the subviews for the game_activity_layout
        gameUIViewController = new GameUIViewController(gameUIModel);
        letterGridViewController = new LetterGridViewController(letterGridModel);
        letterSelectionViewController = new LetterSelectionViewController(letterSelectionModel);

        EventBus.getInstance().broadcastGameEvent(new StartGameEvent(this));
    }

    public void pause()
    {}

    public void resume()
    {}

    public void destroy()
    {
        EventBus.reset();
        gameUIModel.destroy();
        letterGridModel.destroy();
        gameUIViewController.destroy();
        letterGridViewController.destroy();
        letterSelectionViewController.destroy();
        letterSelectionModel.destroy();

        gameUIModel=null;
        letterGridModel=null;
        gameUIViewController=null;
        letterGridViewController=null;
        super.destroy();
    }

}
