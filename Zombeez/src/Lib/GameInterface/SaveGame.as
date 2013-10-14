package Lib.GameInterface 
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import Lib.GameInterface.GameInterface;
	import Lib.Player.Player;
	import Lib.SavedGame.SavedGame;
	import Lib.GameEvent.SaveGameEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Rex
	 */
	public class SaveGame extends GameInterface
	{
		public var savedGames:Array;
		
		public var Slot1:SavedGame;
		public var Slot2:SavedGame;
		public var Slot3:SavedGame;	
		public var AutoSave:SavedGame;
		
		public var BackToMap:SimpleButton;
		
		public function SaveGame()
		{super(); 
		}
		
		public function init(p:Player):void
		{		
		
			player = p;
			Name = "SaveGame";
			
			savedGames = new Array();
		
			//push saved game slots to the array
			Slot1.init(player);
			Slot2.init(player);
			Slot3.init(player);
			AutoSave.init(player);
			
			//push to inventory
			savedGames.push(Slot1);
			savedGames.push(Slot2);
			savedGames.push(Slot3);			
			savedGames.push(AutoSave);
			
			//add event listeners
			for (var g:int = 0; g < savedGames.length; g++)
			{
				savedGames[g].d.addEventListener("SaveGame", onSaveGame);
				savedGames[g].d.addEventListener("LoadGame", onLoadGame);
			}
			
			addEventListener(MouseEvent.CLICK, onClick);
			
			//perform some special operations on the auto save *you can only ever load it*			
			AutoSave.SaveGameButton.alpha = 0;
		}
		public function onClick(e:MouseEvent):void
		{
			sf.playSound("ClickSound");
			switch(e.target.name)
			{
				case "BackToMap":
					Update("LoadMap");
					break;
			}
		}
		public function onSaveGame(e:SaveGameEvent):void
		{
			player.Update(null);
		}
		
		public function onLoadGame(e:SaveGameEvent):void
		{
			player.Update(null);
		}		
	}
}