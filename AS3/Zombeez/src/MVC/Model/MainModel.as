package MVC.Model 
{
	import flash.display.*;
	import flash.display.Loader;
	import flash.events.*;
	import flash.ui.Mouse;
	import flash.media.SoundChannel;
	import Lib.Cursor.Cursor;
	import Lib.GameEvent.GameEvent;
	import Lib.GameLoader.GameLoader;
	import Lib.GameInterface.*;
	import Lib.Player.Player;
	import Lib.Level.Level;
	import Lib.Game.*;
	import Lib.Sound.SoundFactory;
	import Lib.Item.StoreItem;
	import Lib.Weapon.NitroGun;
	
	/**
	 * ...
	 * @author Rex
	 */
	public class MainModel extends EventDispatcher
	{
		//assets
		public var gameData:MovieClip;
		public var stage:Stage;
		public var loader:GameLoader;				
		
		public var player:Player;//the player	
		public var cursor:Cursor;//the cursor
		
		//sounds
		public var sf:SoundFactory;		
		public var interfaces:Array;//store of interfaces
		
		//game interfaces
		public var saveGameScreen:SaveGame;
		public var mapScreen:Map;
		public var storeScreen:Store;
		public var erniesScreen:Ernies;
		public var achievementsScreen:Achievements;
		public var instructionsScreen:Instructions;
		public var scanplayScreen:ScanPlayPreLoader;
		public var game:Game;
				
		public function MainModel(gd:MovieClip, s:Stage, l:GameLoader) 
		{
			super();
			gameData = gd;
			stage = s;					
			loader = l;			
			sf = new SoundFactory();
			
			//get the assets out of the loader dynamically			
			trace("MainModel::LoadingGameSWFAssets");
			
			interfaces = new Array();//place to put the game interfaces			
			
			var playerClass:Class = loader.getAssetClassByName("Lib.Player.Player") as Class;
			var cursorClass:Class = loader.getAssetClassByName("Lib.Cursor.Cursor") as Class;
			var saveGameClass:Class = loader.getAssetClassByName("Lib.GameInterface.SaveGame") as Class;
			var mapClass:Class = loader.getAssetClassByName("Lib.GameInterface.Map") as Class;
			var storeClass:Class = loader.getAssetClassByName("Lib.GameInterface.Store") as Class;
			var erniesClass:Class = loader.getAssetClassByName("Lib.GameInterface.Ernies") as Class;
			var achievementsClass:Class = loader.getAssetClassByName("Lib.GameInterface.Achievements") as Class;
			var instructionsClass:Class = loader.getAssetClassByName("Lib.GameInterface.Instructions") as Class;
			var scanplayClass:Class = loader.getAssetClassByName("Lib.GameInterface.ScanPlayPreLoader") as Class;			
			var gameClass:Class = loader.getAssetClassByName("Lib.GameInterface.Game") as Class;
			
			//create the player						
			player = (new playerClass()) as Player;	
			
			//create the cursor, turn off the mouse, replace with the cursor
			cursor = new cursorClass() as Cursor;
			
			//configure the cursor's Settings
			stage.addEventListener(MouseEvent.MOUSE_MOVE, updateCursor);
			Mouse.hide();
			stage.addChild(cursor);
			
			//create the interfaces		
			trace("MainModel::Creating Game Interfaces from loader");
			game = new gameClass();
			saveGameScreen = new saveGameClass();
			storeScreen = new storeClass();
			erniesScreen = new erniesClass();
			achievementsScreen = new achievementsClass();
			instructionsScreen = new instructionsClass();
			scanplayScreen = new scanplayClass();
			mapScreen = new mapClass();			
			
			//push to interfaces array
			interfaces.push(saveGameScreen);
			interfaces.push(storeScreen);
			interfaces.push(erniesScreen);
			interfaces.push(achievementsScreen);
			interfaces.push(mapScreen);
			interfaces.push(instructionsScreen);
			interfaces.push(scanplayScreen);
			interfaces.push(game);
			
			//init the interfaces
			trace("MainModel::Initializing Game Interfaces");
			saveGameScreen.init(player);
			erniesScreen.init(player);
			storeScreen.init(player);
			achievementsScreen.init(player);
			instructionsScreen.init();
			scanplayScreen.init();
			mapScreen.init(player);
			
			trace("MainModel::Adding objects to the stage now");
			//add them all to the stage but (they are all invisible by default), add event listeners
			for (var g:int = 0; g < interfaces.length; g++)
			{
				stage.addChild(interfaces[g]);
				interfaces[g].d.addEventListener("Update", Update);
			}
			
			loadInterface("ScanPlayPreLoader");
		}		
		
		public function loadInterface(interfaceName:String):void
		{
			trace("MainModel::Loading Interface::" + interfaceName);
			for (var g:int = 0; g < interfaces.length; g++)
			{
				if (interfaces[g].Name == interfaceName)
				{
					interfaces[g].visible = true;
					
					//play the soundtrack
					if (interfaces[g].Name == "Game")
					{
						sf.playLoopByName("FightMusic");
					}
					else
					{
						sf.playLoopByName("ThemeMusic");
					}
				}
				else
				{
					interfaces[g].visible = false;
				}
			}
		}
		
		public function loadGame():void
		{
			var gameModel:GameModel = new GameModel(player);
			var gameController:GameController = new GameController(gameModel);
			
			for (var g:int = 0; g < interfaces.length; g++)
			{
				if (interfaces[g].Name == "Game")
				{
					loadInterface("Game");
					interfaces[g].init(gameModel, gameController);
				}
				
			}
		}
		
		public function updateCursor(e:MouseEvent):void
		{
			cursor.x = e.stageX;
			cursor.y = e.stageY;			
			stage.setChildIndex(cursor, stage.numChildren - 1 );			
		}
		
		public function Update(e:GameEvent):void
		{
			trace("MainModel::RecievedUpdate::" + e.command);
			var g:GameEvent = new GameEvent(e.command);
			dispatchEvent(g);
		}
		
	}

}