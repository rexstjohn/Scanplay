package com.core 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.*;
	import com.game.objects.PlatformFactory;
	import com.menu.factory.*;
	import com.menu.menu.SpeechScript;
	import com.physics.*;
	import com.physics.blocks.PhysicsObject;
	import com.physics.controllers.ContactListener;
	import com.core.*;
	import com.core.factory.*;
	import com.core.user.*;
	import com.game.*;
	import com.game.*;
	import com.game.ship.*;
	import com.game.ui.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	import mochi.as3.*;
	/**
	 * ...
	 * @author ScanPlay Games
	 * 
	 * Everything we need to create a game level
	 */
	public class GameLevel 
	{		
		//everything we need to do a level		 			 
		private static var camera:Camera;
		private var contactListener:ContactListener;
		
		//level stuff
		public static var objectives:Array;
		public static var levelObjects:Array;
		
		//level statistics
		public static var par:int;
		public static var levelID:int;
		public static var started:Boolean;
		public static var shotsFired:int;
		//public static var totalShots:int;
		public static var kegsExploded:int;
		
		//other fun stuff
		public static var levelOver:Boolean ;
		public static var GridSize:int;
		public static var gameType:String;
		public static var platforms:Array;
		public static var levelWon:Boolean;
		
		public static var background:GameBackground;
		public static var water:Water;
		public static var levelUI:LevelUI;
		public static var ship:PirateShip;
		public static var summary:EndOfGameSummary;
		
		//score
		public static var Score:int;
		public static var upgradeScrenShowing:Boolean;
		public static var totalPoints:int; //how many points are in the level
		
		//
		public static var summaryShowing:Boolean = false;
		
		public function GameLevel(_data:Object, _type:String = "Adventure") 
		{
			gameType = _type;
			par = 0;
			shotsFired = 0;
			upgradeScrenShowing = true;
			levelOver = false;
			levelWon = false;
			started  = false;
			summaryShowing = false;
			kegsExploded = 0;
			
			//create stuff
			camera       = new Camera();
			objectives   = new Array();
			levelObjects = new Array();						
			
			//import the data
			par         = int(_data["par"]) ;
			GridSize    = _data["gridsize"];
			levelID     = _data["levelnumber"];
			
			//create our world
			var gameScene:GameWorld = new GameWorld();			
			
			//this is the contact listener that resolves how forcefully objects collide
			GameWorld.m_world.SetContactListener(contactListener = new ContactListener(this));
			
		}		
		
		//delays the start of a level by a couple seconds
		public function start(_focusPoint:Point):void
		{			
			MochiEvents.startPlay(String("Level: " + levelID));
			PlatformFactory.AddShadow();	
			
			//add the magical shadow under the platforms. 
			//platforms.SortZIndex();
			levelUI = new LevelUI();
						
			//now load everything and get it going...
			GameWorld.start();
			Water.AddFloatingBodies(levelObjects);
			
			//start the camera pointing at the objects
			Camera.SetFocusPoint(_focusPoint);
			Camera.SetPanLocked(true);			
			
			Services.BeginPlay();
			Main.m_sprite.addEventListener(Event.ENTER_FRAME, handleEnter);
			Main.m_stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			started = true;		
			
			//if this is level 1, pop the tutorial immediately
		//	if(!SpeechScript.HasScriptBeenLoaded( "Level_1_Tutorial") && levelID == 1)
		//	GameController.HandleEvent("LoadScript", "Level_1_Tutorial");			
		}
		
		//if the player hits R, reset the level		
		public static function handleKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == 82 && started && !PirateShip.tutorialRunning && !ShotCounter.deathTimerStarted)
			{
				levelOver = true;
				GameController.HandleEvent("ReloadLastLevel", levelID);
			}
		}
		
		public static function isStarted():Boolean
		{
			return started;
		}
		
		public static function UpdateScore(points:int):void
		{
			/*I have to do this to counter cases where people make a level
			 * where things die before the level gets a chance to start
			 */ 
			if (PirateShip.lastShot)
			{
				var multiplier:Number = 1 + int(UserData.StarCrateCount() / 10);
				
				//increment the multiplier of the current shot
				if(PirateShip.lastShot.shotMultiplier == 3)
				{
					MessageFactory.CreateMessage("Points x" + 3, 5 * PirateShip.lastShot.shotMultiplier, 10* PirateShip.lastShot.shotMultiplier);
					multiplier += 3;
				
				}
				if(PirateShip.lastShot.shotMultiplier == 6)
				{
					MessageFactory.CreateMessage("Points x" + 6, 8 * PirateShip.lastShot.shotMultiplier, 15* PirateShip.lastShot.shotMultiplier, true,1000,false,0xff8c00);
					multiplier += 6;
				}
				if(PirateShip.lastShot.shotMultiplier == 10)
				{
					MessageFactory.CreateMessage("Points x" + 10, 10 * PirateShip.lastShot.shotMultiplier, 20 * PirateShip.lastShot.shotMultiplier, true, 1000, false, 0xff0000);
					multiplier += 10;			
				}
				
				Score += int(points * 10 * (multiplier));
				LevelUI.UpdateScore();
				PirateShip.lastShot.shotMultiplier++;
			}	
			
		}
		
		public static function SetDefaultCameraTarget(o:PhysicsObject):void
		{
			trace("Setting Default Camera Target::" + o);
			Camera.SetDefaultTarget(o);
		}
		
		public static function AddObject(o:GameObject):void
		{
			levelObjects.push(o);
			
			if(o is PhysicsObject)
			totalPoints += PhysicsObject(o).GetPoints();
		}
		
		public static function AddObjective(o:String):void
		{
			objectives.push(o);
		}
		
		public static function GetObjectByBody(b:b2Body):PhysicsObject
		{
			var ret:PhysicsObject = null;
			
			for each(var i:* in levelObjects)
			{
				if (i is PhysicsObject)
				{
					if (i.GetBody() == b)
					{
						ret = i;
					}
				}
			}
			
			return ret;
		}
		
		//fired when a treasure is opened
		public static function CompleteObjective(objectiveName:String):void
		{
			for each(var o:String in objectives)
			{
				if (o == objectiveName)
				{					
					MessageFactory.CreateMessage("Objective Completed!");						
					objectives.splice(objectives.indexOf(o), 1);
					break;
				}
			}
		}
		
		/*
		 * The game automatically loses if the player runs out of objectives (gets all the treasure, kills all the pirates)
		 * and skips to the end game screen. For the first 5 levels, the player gets to win without trying very hard.
		 * After that, we start enforcing the par. 
		 * 
		 */ 
		public static function handleEnter(e:Event):void
		{		
			if ((objectives && objectives.length == 0))
			HandleLevelOver();
		}
		
		public static function HandleLevelOver():void
		{		
			Main.m_sprite.removeEventListener(Event.ENTER_FRAME, handleEnter);
				
				if (started )
				{
					started = false;
					LevelUI.HideUI();
					Services.EndPlay();	
						
					//start a brief timer so the between level transition is not instant (confusing to users)					
					var t:Timer = new Timer(1500);
					t.addEventListener(TimerEvent.TIMER, handleTimer);
					t.start();
					
					function handleTimer(e:TimerEvent):void
					{				
						Camera.FollowDefault(); //reset the camera to the ship				
						t.stop();
						t.removeEventListener(TimerEvent.TIMER, handleTimer);	
						Camera.SetPanLocked(true);											
						
						switch(gameType)
						{
							case "Adventure":
								//handle the conditions under which the level was ended
								summaryShowing = true;
								
								//the score before we adjust it for par bonus
								var nonAdjustedScore:int = Score;
								
								//add the extra shots to the score
								if(shotsFired <= par)
								Score += (300 * (par - shotsFired));
								
								summary = new EndOfGameSummary((shotsFired <= par) && (objectives.length == 0), Score, totalPoints, nonAdjustedScore);
								
								//check if we got a skull and bones
								if (shotsFired <= par && (objectives.length == 0))
								{
									UserData.AwardSkullAndBones(levelID);	
									Services.TrackEvent("level won", levelID);	
									UserData.UnlockLevel(levelID + 1);	
								}
								
								MochiEvents.endPlay();//end the play	
								break;
							case "Custom":
								GameController.HandleEvent("ExitFromGameToMenu");
								break;
						}
					}
				}
		}
		
		public static function OnLevelLost():void
		{
			levelOver = true;
		}
		
		public static function destroy(exitCondition:String = "NextLevel"):void
		{			
			Main.m_sprite.removeEventListener(Event.ENTER_FRAME, handleEnter);
			Main.m_stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			started = false;
			levelOver = true;
			LevelUI.destroy();
			Camera.destroy();
			Score = 0;
			if(summary)
			summary.destroy();
			
			ship.Destroy();			
			var i:PhysicsObject;
			
			//sweep the level objects			
			for each(i in levelObjects)
			{
				if (i is PhysicsObject)
				{
					if(i.IsAlive())
					PhysicsObject(i).Destroy(true);		
					
					i = null;
				}
			}
			
			while (levelObjects.length > 0)
			levelObjects.splice(0, 1);
			
			GameWorld.destroy();
			platforms    = null;
			levelObjects = null;
			camera = null;			
		}
		
		public static function GetObjects():Array
		{
			return levelObjects;
		}
	}
}