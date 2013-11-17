package Lib.GameInterface 
{
	import Lib.Game.GameInventory.GameInventory;
	import Lib.Game.GameProgressBar.GameProgressBar;
	import Lib.Game.GameSpeedSlider.GameSpeedSlider;
	import Lib.Game.HealthBar.HealthBar;
	import Lib.Game.GameModel;
	import Lib.Game.GameController;
	import flash.display.*;
	import flash.events.*;
	import Lib.GameEvent.*;
	import flash.utils.Timer;
	import Lib.GameInterface.GameInterface;
	import Lib.Player.Player;
	import flash.text.*;
	import Lib.Item.InventoryItem;
	import Lib.Item.StoreItem;
	import Lib.Game.GameBackground.GameBackground;
	import mochi.as3.*;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class Game extends GameInterface
	{
		
		public var gameModel:GameModel;
		public var gameController:GameController;
		
		public var gameTimer:Timer;//timer
		
		//important textfields
		public var KillNumber:TextField;
		public var Time:TextField;
		public var LevelNumber:TextField;
		
		//interface items		
		public var gameInventory:GameInventory;
		public var healthBar:HealthBar;
		public var CountDown:MovieClip;
		public var YouLose:MovieClip;
		public var YouWin:MovieClip;
		public var BackToMap:SimpleButton;
		public var SpeedSlider:GameSpeedSlider;
		public var ProgressBar:GameProgressBar;
		public var YouWinTheGame:MovieClip;
		public var CoinsLeft:TextField;
				
		//inventory		
		public var Slot1:InventoryItem;
		public var Slot2:InventoryItem;
		public var Slot3:InventoryItem;
		public var Slot4:InventoryItem;
		public var Slot5:InventoryItem;
		
		//game background
		public var Background:GameBackground;
		
		public function Game() 
		{
			Name = "Game";
		}	
		
		public function init(gm:GameModel, gc:GameController):void
		{
			gameModel = gm;
			gameController = gc;
			gameModel.init(this);//load the game to the model
			
			//track a game start
			mochi.as3.MochiEvents.startPlay('normal');
			
			//disable the textfields from being clicked on			
			KillNumber.mouseEnabled = false;
			Time.mouseEnabled = false;
			LevelNumber.mouseEnabled = false;
			
			addEventListener(Event.ENTER_FRAME, doCountDown);
			
			function doCountDown(e:Event):void
			{			
				if (CountDown.currentLabel == "Done")
				{
					removeEventListener(Event.ENTER_FRAME, doCountDown);
					trace("Game::StartingGameNow");	
					
					gameTimer = new Timer(6000);				
					gameTimer.addEventListener("timer", onTimer);
					gameModel.addEventListener("Update" , UpdateGame);
					
					addEventListener(MouseEvent.CLICK, onClick);
					addEventListener(Event.ENTER_FRAME, onEnter);
					addEventListener(MouseEvent.MOUSE_MOVE, onMove);
								
					gameTimer.start();		
					gameModel.equipPistol();
					BackToMap.visible = true;
					gameController.createWave();
				}
			}	
		}
		
		private function onTimer(e:TimerEvent):void
		{gameController.handleTimer(e); Time.text = String(gameTimer.currentCount); }
		
		private function onEnter(e:Event):void
		{gameController.handleEnter(e);}
		
		private function onMove(e:MouseEvent):void
		{gameController.handleMove(e); }
		
		private function onClick(e:MouseEvent):void
		{gameController.handleClicks(e); }
		
		public function UpdateGame(e:GameEvent):void
		{
			switch(e.command)
			{
				case "CreatureDeath":
					KillNumber.text = String(gameModel.gameKills);
					gameModel.ProgressBar.updateKillProgress(gameModel.gameKills);
					
					if (gameModel.ProgressBar.percentageLeft == 0)
					{
						trace("Game::GameOver You Win::");
						YouWin.gotoAndStop("YouWin");
						gameModel.disableUI();
						Update("StopMusic"); //tell the sound factory to stop the sound track
						
						if ((gameModel.player.LevelsBeaten == gameModel.level.levelNumber))
						{							
							if (gameModel.player.LevelsBeaten == 11)
							{								
								trace("Game::Player Has Won The Game, Updating");
								YouWinTheGame.visible = true;
								gameModel.player.visible = false;
								YouWin.visible = false;
								removeEventListener(Event.ENTER_FRAME, onEnter);
								removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
								gameTimer.stop();
							}
							else
							{
								trace("Game::Player Has Beaten A Level, Updating");
								gameModel.player.LevelsBeaten++;
								gameModel.player.Update("LevelBeaten");
								removeEventListener(Event.ENTER_FRAME, onEnter);
								removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
							}
						}
					}
					break;
				case "CreatureSpawned":
					break;
				case "PlayerDead":
					trace("Game::UpdateGame::GameOver");
					gameModel.disableUI();
					removeEventListener(Event.ENTER_FRAME, onEnter);
					removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
					gameTimer.stop();
					gameModel.removeAllZombies();
					YouLose.gotoAndStop("YouLose");
					gameModel.player.resetColorTransform();
					Update("StopMusic"); //tell the sound factory to stop the sound track
					break;
				case "BackToMap":
					removeEventListener(Event.ENTER_FRAME, onEnter);
					removeEventListener(MouseEvent.CLICK, onClick);
					removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
					gameTimer.stop();
					gameModel.destroy();
					sf.playSound("ClickSound");
					Update("LoadMap");
					Update("AutoSave"); //autosave the game
					break;
			}
		}
		
	}

}