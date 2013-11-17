package Lib.SavedGame 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.text.TextField;
	import Lib.GameObject;
	import Lib.Player.Player;
	import flash.net.SharedObject;
	import flash.events.*;
	import Lib.GameEvent.SaveGameEvent;
	import mochi.as3.*;
	
	/**
	 * ...
	 * @author Rex
	 */
	public class SavedGame extends GameObject
	{
		public var player:Player;
		
		public var PlayerStats:SharedObject;
		public var PlayerInventory:SharedObject;
		public var PlayerAchievements:SharedObject;
		
		//objects		
		public var SlotName:TextField = new TextField();
		public var TimeStamp:TextField = new TextField();
		public var LevelsBeaten:TextField = new TextField();
		public var Message:TextField = new TextField();
		
		public var LoadGameButton:SimpleButton = new SimpleButton();
		public var SaveGameButton:SimpleButton = new SimpleButton();		
		
		//time stamo
		public var date:Date = new Date();
		
		public function SavedGame() 
		{
			super("SavedGame");		
		}
		
		public function init(p:Player):void
		{
			player = p;
			Name = name;
			
			SlotName.text = Name;
			buttonMode = true;
			
			LoadGameButton.visible = false;
			SaveGameButton.visible = false;
			
			//load the shared objects
			PlayerStats = SharedObject.getLocal(name + "PlayerStats");
			PlayerInventory = SharedObject.getLocal(name + "PlayerInventory");
			PlayerAchievements = SharedObject.getLocal(name + "PlayerAchievements");
			
			
			//populate the fields if there is data in the shared objects already
			if (PlayerStats.data.TimeStamp != undefined)
			{
				TimeStamp.text = String(PlayerStats.data.TimeStamp);
			}
			else 
			{
				TimeStamp.text = String("");
			}
			
			if (PlayerStats.data.LevelsBeaten != undefined)
			{
				LevelsBeaten.text = String(PlayerStats.data.LevelsBeaten);
			}
			else
			{
				LevelsBeaten.text = String("[Empty]");
				LoadGameButton.mouseEnabled = false;
				LoadGameButton.alpha = 0;
			}
			
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(MouseEvent.MOUSE_OVER, onOver);
			addEventListener(MouseEvent.MOUSE_OUT, onOut);
		}
		
		public function onClick(e:MouseEvent):void
		{
			sf.playSound("ClickSound");
			switch(e.target.name)
			{
				case "SaveGameButton":
					saveGame();
					break;
				case "LoadGameButton":
					loadGame();
					break;
			}		
		}
		
		public function onOver(e:MouseEvent):void
		{
			glowRed();
			LoadGameButton.visible = true;
			SaveGameButton.visible = true;
		}
		
		public function onOut(e:MouseEvent):void
		{
			filters = [];
			LoadGameButton.visible = false;
			SaveGameButton.visible = false;
			Message.visible = false;
		}
		public function Update(e:SaveGameEvent):void
		{
			d.dispatchEvent(e);
		}
		
		public function saveGame():void
		{
				trace("SaveGameSlot::" + Name + "::SavingGame");				
				
				LoadGameButton.mouseEnabled = true;
				LoadGameButton.alpha = 1;
				
				//clean out the old data and reinstance the shared objects			
				PlayerStats.clear();
				PlayerInventory.clear();
				PlayerAchievements.clear();					
				
				PlayerStats = SharedObject.getLocal(Name + "PlayerStats");
				PlayerInventory = SharedObject.getLocal(Name + "PlayerInventory");
				PlayerAchievements = SharedObject.getLocal(Name + "PlayerAchievements");				
				
				//now load the new data
				PlayerStats.data.Kills = player.Kills;
				PlayerStats.data.LevelsBeaten = player.LevelsBeaten;
				PlayerStats.data.Coins = player.Coins; //number of coins the player has
				
				/*
				 * 
				 * SET THE DATE				 * 
				 * 
				 */
				
				
				//make the date pretty				
				var thismonth:uint = date.getMonth();
				var hour:uint =  date.getHours();
				var minute:uint =  date.getMinutes();
				var minuteForm:String = String(minute);
				var amPM:String = "AM";
				
				if(hour > 12)
				{
					amPM = "PM";
					hour -= 12;
				}	
				if( (minute) < 10)
				{
					minuteForm = "0" + minute;
				}
				
				var mnth:Array = new Array('January','February','March','April','May','June','July','August','September','October','November','December');
				var date_str:String = (hour + ":" + minuteForm + " " + amPM + " " +date.getDate() + " " + mnth[thismonth] + " " + date.getFullYear());
				
				PlayerStats.data.TimeStamp = date_str;
				
				/*
				 * 
				 * Store weapons and achievements 
				 * 
				 */
				 
				 //now store the values
				 for (var p:int = 0; p < player.items.length; p++ ) 
				 {
					 PlayerInventory.data["Item" + p] = player.items[p].itemName;
					 trace("SaveGameSlot::Saving Item::" + player.items[p].itemName);
				 }	
				 
				 for (var a:int = 0; a < player.achievements.length; a++ ) 
				 {
					 trace("SaveGameSlot::Saving Achievement::" + player.achievements[a].Name);
					 PlayerAchievements.data["Achievement" + a] = player.achievements[a].Name;					 
				 }	
				/*
				 * 
				 * FLUSH IT!
				 * 
				 */
				
				PlayerStats.flush(); //store it
				PlayerInventory.flush(); //store it
				PlayerAchievements.flush(); //store it
				
				trace("SavedGame::" + Name + "::DATA SAVED!");
				
				 for (var prop:* in PlayerStats.data) 
				 {
					trace(prop+": "+PlayerStats.data[prop]);
				 }
				 
				  for (var prop2:* in PlayerInventory.data) 
				 {
					trace(prop2+": "+PlayerInventory.data[prop2]);
				 } 
				 
				 for (var prop3:* in PlayerAchievements.data) 
				 {
					trace(prop3+": "+PlayerAchievements.data[prop3]);
				 }
				 TimeStamp.text = String(PlayerStats.data.TimeStamp);
				 Message.text = "Game Saved!";
				 Message.filters = [];
				 Message.visible = true;
				 LevelsBeaten.text = String(player.LevelsBeaten);
				mochi.as3.MochiEvents.trackEvent('GameSaved'); //track a game completion
		}
		
		public function loadGame():void
		{
			trace("SaveGameSlot::" + Name + "::LoadingGame");
			
			player.Kills = PlayerStats.data.Kills;
			player.LevelsBeaten = PlayerStats.data.LevelsBeaten;
			player.Coins = PlayerStats.data.Coins;
			
			//wipe the items and achievements menus
			player.items = new Array();
			player.achievements = new Array();
				
			for (var item:* in PlayerInventory.data)
			{
				player.items.push(PlayerInventory.data[item]);
				trace("item Loaded::" + PlayerInventory.data[item]);
			}
			
			for (var achievement:* in PlayerAchievements.data)
			{				
				player.achievements.push(PlayerAchievements.data[achievement]);
				trace("Achievement Loaded::" + PlayerAchievements.data[achievement]);
			}
						
			 Message.text = "Game Loaded!";
			 Message.visible = true;
			 Message.filters = [];
			 
			 //push a pistol to the player's inventory
			// player.items.push("Pistol");
			 
			 player.Update("LoadGame"); //tell the store, achievements menu to reload themselves
			mochi.as3.MochiEvents.trackEvent('GameLoaded', 1); //track a game completion
		}
		
	}

}