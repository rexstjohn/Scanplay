package MVC.View 
{
	import flash.display.*;
	import flash.events.Event;
	import Lib.GameEvent.*;
	import Lib.GameLoader.GameLoader;
	import Lib.Tools.*;
	import MVC.Model.MainModel;
	import flash.net.*;
	import flash.system.*;
	
	/**
	 * ...
	 * @author Rex
	 */
	public dynamic class MainView extends MovieClip
	{
		public var gameLoader:GameLoader;
		public var gameData:MovieClip;		
		public var mainModel:MainModel;		
		
		//variables to making sure everything is loaded
		public var adFinished:Boolean = false;
		public var loadFinished:Boolean = false;
		
		public function MainView() 
		{	
			var _mochiads_game_id:String = "418dfe5f83af8134";
			gameLoader = new GameLoader(stage);
			gameLoader.addEventListener("Update", Update);
			
			//do mochi stuff		
			gameLoader.load();
		}
		
		public function initGame():void
		{									
			//make sure the stage exists before starting the main model
			mainModel = new MainModel(gameData, stage, gameLoader);
			mainModel.addEventListener("Update", Update);
		}
		
		public function Update(e:GameEvent):void
		{
			trace("MainView::RecievedUpdate::" + e.command);
			switch(e.command)
			{
				case "LoadComplete":
					trace("MainView::LoadCompleted");		
					initGame();				
					break;
				case "LoadMap":
					mainModel.loadInterface("Map");
					break;
				case "LoadStore":
					mainModel.loadInterface("Store");
					break;
				case "LoadSaveGame":
					mainModel.loadInterface("SaveGame");
					break;
				case "LoadErnies":
					mainModel.loadInterface("Ernies");
					break;
				case "LoadAchievements":
					mainModel.loadInterface("Achievements");
					break;
				case "LoadCoinStore":
					mainModel.loadInterface("CoinStore");
					break;
				case "LoadInstructions":
					mainModel.loadInterface("Instructions");
					break;
				case "LoadLevel":
					//show an ad before a level starts
					mainModel.loadGame(); 
					break;
				case "StopMusic":
					mainModel.sf.sndChannel.stop();
					break;		
				case "AutoSave":
					//auto save the game everytime the player exits a gameplay session, slotmachine or game store areas
					mainModel.saveGameScreen.AutoSave.saveGame();
					break;
			}
					
		}
	}

}