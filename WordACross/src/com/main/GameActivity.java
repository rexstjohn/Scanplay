package com.main;

import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import com.controllers.GameController;
import com.controllers.GameViewController;
import com.events.*;
import com.glue.EventBus;
import com.glue.IGameEventListener;
import com.utils.GameDialogue;
import com.views.GameView;
import org.cocos2d.layers.CCScene;
import org.cocos2d.nodes.CCDirector;
import org.cocos2d.opengl.CCGLSurfaceView;

import android.app.Activity;
import android.os.Bundle;
import android.view.Window;
import android.view.WindowManager;

public class GameActivity extends Activity implements IGameEventListener
{
    private static final double SHAKE_SENSITIVITY = 2.75;

    // For shake motion detection.
    private SensorManager mSensorManager;
    private float mAccel; // acceleration apart from gravity
    private float mAccelCurrent; // current acceleration including gravity
    private float mAccelLast; // last acceleration including gravity

    //
    private GameViewController gameViewController;
    protected CCGLSurfaceView _glSurfaceView;
    private boolean isDestroyed;
    private String gameMode;

	@Override
	public void onCreate(Bundle savedInstanceState)
	{
        super.onCreate(savedInstanceState);

        //set up the shake listener
        mSensorManager = (SensorManager) getSystemService(getApplicationContext().SENSOR_SERVICE);
        mSensorManager.registerListener(mSensorListener, mSensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER), SensorManager.SENSOR_DELAY_NORMAL);
        mAccel = 0.00f;
        mAccelCurrent = SensorManager.GRAVITY_EARTH;
        mAccelLast = SensorManager.GRAVITY_EARTH;
	}

    //a game event has occurred
    public void notify(IGameEvent event)
    {
        switch (event.getType())
        {
            case GameEvent.GAME_LOST_EVENT:
            GameLostEvent gameLostEvent = (GameLostEvent)event;

            destroy();
            //TODO:Show "You lose" message here

            //redirect to main menu on loser
            Intent  youLoseIntent = new Intent(this,YouLoseActivity.class);
            Bundle bundle = new Bundle();
            bundle.putInt("gameScore",gameLostEvent.getScore() );
            youLoseIntent.putExtras(bundle);
             startActivityForResult(youLoseIntent, 0);
            break;
        }
    }

    public boolean getIsDestroyed(){return isDestroyed;}

    public void destroy()
    {
        if(isDestroyed)return;//prevent the event bus from over destroying this class

        gameViewController.destroy();
		super.onStop();

        CCDirector.sharedDirector().popScene();
		CCDirector.sharedDirector().end();
        CCDirector.sharedDirector().purgeCachedData();
        isDestroyed = true;
    }

	@Override
	public void onStart()
	{
		super.onStart();
        isDestroyed = false;
        this.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);

        //get the game mode
        Bundle extras = getIntent().getExtras();
        gameMode = extras.getString("gameMode");

		requestWindowFeature(Window.FEATURE_NO_TITLE);
		getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
		getWindow().setFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON, WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);

		_glSurfaceView = new CCGLSurfaceView(this);
		setContentView(_glSurfaceView);

		CCDirector.sharedDirector().attachInView(_glSurfaceView);
		CCDirector.sharedDirector().setDeviceOrientation(CCDirector.kCCDeviceOrientationPortrait);
		CCDirector.sharedDirector().setDisplayFPS(false);
		CCDirector.sharedDirector().setAnimationInterval(1.0f / 60.0f);
        CCDirector.sharedDirector().setLandscape(false);

        //create the scene
		CCScene scene = GameView.getSceneInstance();
		CCDirector.sharedDirector().runWithScene(scene);

        //create the game_activity_layout view controller
        gameViewController = new GameViewController(gameMode);
        EventBus.getInstance().addGameEventListener(this);

        //create the game_activity_layout view controller
        gameViewController.start();
	}

    @Override
    public void onBackPressed()
    {
        //kill the activity on back pressed
        onStop();
        super.onBackPressed();
    }

	@Override
	public void onPause()
	{
	    super.onPause();
        if(isDestroyed)return;
        EventBus.getInstance().broadcastGameEvent(new GamePausedEvent(this));
		CCDirector.sharedDirector().pause();
	}

	@Override
	public void onResume()
	{
		super.onResume();
        if(isDestroyed)return;
        EventBus.getInstance().broadcastGameEvent(new GameResumedEvent(this));
		CCDirector.sharedDirector().resume();
        mSensorManager.registerListener(mSensorListener, mSensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER), SensorManager.SENSOR_DELAY_NORMAL);
	}

	@Override
	public void onStop()
	{
        mSensorManager.unregisterListener(mSensorListener);
        super.onStop();
        destroy();
	}

    //listener for shakes
    private final SensorEventListener mSensorListener = new SensorEventListener()
    {
        public void onSensorChanged(SensorEvent se)
        {
              float x = se.values[0];
              float y = se.values[1];
              float z = se.values[2];
              mAccelLast = mAccelCurrent;
              mAccelCurrent = (float) Math.sqrt((double) (x*x + y*y + z*z));
              float delta = mAccelCurrent - mAccelLast;
              mAccel = mAccel * 0.9f + delta; // perform low-cut filter

            if(mAccel >=SHAKE_SENSITIVITY)EventBus.getInstance().broadcastGameEvent(new ShakeEvent(this));
        }

        public void onAccuracyChanged(Sensor sensor, int accuracy)
        {}
    };
}