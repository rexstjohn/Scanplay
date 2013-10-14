package com.core.user 
{
	import Box2D.Collision.b2Bound;
	import com.core.factory.PopUpFactory;
	import com.core.GameController;
	import flash.net.SharedObject;
	import com.core.factory.MessageFactory;
	import mochi.as3.*;
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * This is an abstract user data object.
	 * 
	 * It can be stored and retrieved in memory.
	 */
	public class UserData
	{
		private static var data:Object;
		private static var so:SharedObject = SharedObject.getLocal("data");
		
		public function UserData() 
		{
			data = new Object();
			
			if(so.data.UserData)
			LoadSharedObject();
			else
			CreateNewUser();
			
			//on creation, user weapon is ALWAYS defaulted to cannonball standard
			data.CurrentPowerUp						= "Cannonball_Standard";
			so.data.UserData = data;
			so.flush();			
		}
		
		//flush an award to the fil
		public static function AwardSkullAndBones(levelId:int):void
		{			
			MochiEvents.trackEvent(String('Skull And Bones Awarded:' + levelId));
			data.SkullAndBones[levelId] = "Unlocked";
			data.Gold += 1000;
			so.data.UserData = data;
			so.flush();
			
			///pester the user to share their accomplishment if they got several skull and bones
			var boneCount:int = 0;
			var nagShown:Boolean = false;
			//ask for a share
			for each(var s:String in data.SkullAndBones)
			{
				if (s == "Unlocked")
				{
					boneCount++;
				}
			}
			
		}
		
		public static function IsLevelSkullAndBones(levelID:int):Boolean
		{
			if(data.SkullAndBones[levelID] == "Unlocked")
			return true;
			else
			return false;
		}
		
		//create a new blank user
		public static function CreateNewUser():void
		{			
			var SkullAndBones:Array = new Array();
			
			//fill the skull and bones index with unlocked
			for (var g:int = 0 ; g < 300; g++)
			{
				SkullAndBones.push("Locked");
			}
			
			data.LevelsUnlocked                     = 1;
			data.Gold                               = 0;
			data.UserName                           = "None";
			data.Episode_1                          = "Unlocked";
			data.Episode_2                          = "Locked";
			data.LevelEditor                        = "Locked";
			data.SkullAndBones                      = SkullAndBones;
			
			//achievements
			data.Launched							= "Locked";
			data.LookOutBehindYou					= "Locked";
			data.Boomer								= "Locked";
			data.FriendlyPirate						= "Locked";
			data.Winner						        = "Locked";
			data.HighScorer						    = "Locked";
			data["20Coins"]					        = "Locked";
			data["40Coins"]						    = "Locked";
			data["20Stas"]					        = "Locked";
			data["40Stars"]						    = "Locked";
			data["SeagullKiller"]                   = "Locked";
			data["PirateSlayer"]                    = "Locked";
			
			//powers			
			data["Cannon Power"] = 0;
			data["Shot Count"]                      = 0; //you can get extra par shots
			data["Bounce"]                          = 0;
			data["Damage"]                          = 0;
			data["Accuracy"]                        = 0;
			data["Shot Size"]                       = 0;
			data["Bones Allocated"]                 = 0;
			data["Par Bonus"]                       = 0;
			
			//some stats
			data.PiratesKilled                      = 0;
			data.SeagullsKilled                     = 0;
			
			//all the coins we have collected
			data["Coins Collected"]                 = new Array();
			
			for (var m:int = 0; m < 40; m++)
			{
				data["Coins Collected"].push(false);
			}
			
			//all the star crates we have collected
			data["StarCrates Collected"]                 = new Array();
			
			for (var x:int = 0; x < 80; x++)
			{
				data["StarCrates Collected"].push(false);
			}
			
			so.data.UserData                        = data;
			so.flush();
		}
		
		public static function CoinCount():int
		{
			var count:int = 0;
			
			for each(var f:Boolean in data["Coins Collected"])
			{
				if(f == true)
				count++;
			}
			
			return count;
		}
		
		public static function SeagullKilled():void
		{
			data.SeagullsKilled++;
			Flush();
			
			if (data.SeagullsKilled == 30)
			{
				UnlockAchievement("SeagullKiller");
			}
		}
		
		public static function PirateKilled():void
		{
			data.PiratesKilled++;
			Flush();
			
			if (data.PiratesKilled == 30)
			{
				UnlockAchievement("PirateSlayer");
			}
		}
		
		public static function StarCrateCount():int
		{
			var count:int = 0;
			
			for each(var f:Boolean in data["StarCrates Collected"])
			{
				if(f == true)
				count++;
			}
			
			return count;
		}
		
		public static function GetCoinsCollected():Array
		{
			return data["Coins Collected"];
		}
		
		
		public static function GetStarCratesCollected():Array
		{
			return data["StarCrates Collected"];
		}
		
		
		//use this shit to set stat counts for the upgrade screen		
		public static function SetStat(stat:String, num:int):void
		{
			data[stat] = num;
			so.data.UserData = data;
			so.flush();
		}
		
		public static function Flush():void
		{			
			so.data.UserData = data;
			so.flush();
		}
	
		public static function DeallocateBones():void
		{
			data["Bones Allocated"]--;
			so.data.UserData = data;
			so.flush();
		}
		
		public static function AllocateBones():void
		{
			data["Bones Allocated"]++;
			so.data.UserData = data;
			so.flush();
		}
		
		public static function GetStat(stat:String):int
		{
			return data[stat];
		}
		
		public static function GetBones():int
		{
			var count:int = 0;
			
			for each(var u:String in data.SkullAndBones)
			{
				if(u == "Unlocked")
				count++;
			}
			
			return (count);
		}
		
		public static function GetCurrentWeapon():String
		{
			return data.CurrentPowerUp;
		}
		
		public static function SetCurrentWeapon(s:String):void
		{
			data.CurrentPowerUp = s;
			so.data.UserData = data;
			so.flush();
		}
		
		public static function UnlockAchievement(s:String):void
		{
			MochiEvents.trackEvent(String('Achievement Unlocked::' + s));
			switch(s)
			{
				case "Launched":
					if(data.Launched == "Locked")
					{
						data.Launched = "Unlocked";
						PopUpFactory.CreateAchievementPop("Achievement Unlocked", "Launched!");
						GameController.HandleEvent("PostAchievementToStream", s);
					}					
					break;
				case "LookOutBehindYou":
					if (data.LookOutBehindYou == "Locked")
					{
						data.LookOutBehindYou = "Unlocked";
						PopUpFactory.CreateAchievementPop("Achievement Unlocked", "Look Out!");						
						GameController.HandleEvent("PostAchievementToStream", "Look Out Behind You!");
					}
					break;
				case "SeagullKiller":
					if (data.SeagullKiller == "Locked")
					{
						data.SeagullKiller = "Unlocked";
						PopUpFactory.CreateAchievementPop("Achievement Unlocked", "Seagull Killer!");
						GameController.HandleEvent("PostAchievementToStream", "Seagull Slayer");					
					}
					break;
				case "PirateSlayer":
					if (data.PirateSlayer == "Locked")
					{
						data.PirateSlayer = "Unlocked";
						PopUpFactory.CreateAchievementPop("Achievement Unlocked", "Pirate Slayer!");
						GameController.HandleEvent("PostAchievementToStream", "Pirate Slayer!");	
					}
					break;
				case "Boomer":
					if (data.Boomer == "Locked")
					{
						data.Boomer = "Unlocked";
						
						PopUpFactory.CreateAchievementPop("Achievement Unlocked", "Boomer!");
						GameController.HandleEvent("PostAchievementToStream", "Boomer!");				
					}
					break;
				case "FriendlyPirate":
					if (data.FriendlyPirate == "Locked")
					{
						data.FriendlyPirate = "Unlocked";
						PopUpFactory.CreateAchievementPop("Achievement Unlocked", "Friendly Pirate!");				
					}
					break;
				case "20Coins":
					if (data["20Coins"] == "Locked")
					{
						data["20Coins"]  = "Unlocked";
						PopUpFactory.CreateAchievementPop("Achievement Unlocked", "Sharp Shooter!");	
						GameController.HandleEvent("PostAchievementToStream", "Sharp Shooter!");		
					}
					break;
				case "40Coins":
					if (data["40Coins"]  == "Locked")
					{
						data["40Coins"] = "Unlocked";
						PopUpFactory.CreateAchievementPop("Achievement Unlocked", "Sea Dog!");	
						GameController.HandleEvent("PostAchievementToStream", "40 Coins Found!");			
					}
					break;
				case "20Stars":
					if (data["20Stars"] == "Locked")
					{
						data["20Stars"] = "Unlocked";
						PopUpFactory.CreateAchievementPop("Achievement Unlocked", "Certified Pirate!");		
						GameController.HandleEvent("PostAchievementToStream", "Certified Pirate!");		
					}
					break;
				case "40Stars":
					if (data["40Stars"] == "Locked")
					{
						data["40Stars"]  = "Unlocked";
						PopUpFactory.CreateAchievementPop("Achievement Unlocked", "Scourge!");				
					}
					break;
				case "HighScorer":
					if (data.HighScorer == "Locked")
					{
						data.HighScorer = "Unlocked";
						PopUpFactory.CreateAchievementPop("Achievement Unlocked", "High Scorer");				
					}
					break;
				case "Winner":
					if (data.Winner == "Locked")
					{
						data.Winner = "Unlocked";
						PopUpFactory.CreateAchievementPop("Achievement Unlocked", "Winner");
						GameController.HandleEvent("PostAchievementToStream", "I Beat Get The Treasure!");
					}
					break;
			}
			
			so.data.UserData = data;
			so.flush();
		}
		
		public static function IsEpisodeLocked(s:String):Boolean
		{
			var locked:String;
			
			switch(s)
			{
				case "episode_1":
					locked = data.Episode_1 
					break;
				case "episode_2":
					locked = data.Episode_2
					break;
			}
			
			if(locked == "Locked")			
			return true;
			else
			return false;
		}
		
		//adds ammo of the input type
		public static function BuyPowerUp(s:String):void
		{
			switch(s)
			{
				case "Cannonball_Explosive":
					data.CurrentPowerUp = s;
					//Services.ShowItem("Cannonball_Exploding");
					break;
				case "Cannonball_Triple":
					data.CurrentPowerUp = s;
					//Services.ShowItem("Cannonball_Exploding");
					break;
				case "Cannonball_Rubber":
					data.CurrentPowerUp = s;
					//Services.ShowItem("Cannonball_Exploding");
					break;
			}
			so.data.UserData = data;
			so.flush();			
		}
		
		public static function GetAmmoLeft(s:String):int
		{
			var left:int = 0;
			
			switch(s)
			{
				case "ExplosiveShotCrate":
					left = data.ExplosiveShotsLeft;
					break;
				case "TripleShotCrate":
					left = data.TripleShotsLeft;
					break;
				case "RubberShotCrate":
					left = data.RubberShotsLeft;
					break;
			}
			
			return left;
		}
		
		public static function UnlockEpisode(id:int = 2):void
		{
			switch(id)
			{
				case 2:
					break;
			}
		}
		
		public static function LoadSharedObject():void
		{
			//flush the data
			data = so.data.UserData;	
		}
		
		public static function LevelsUnlocked():Number
		{
			return data.LevelsUnlocked;
		}
		
		public static function AddGold(i:int):void
		{
			data.Gold += i;
			so.flush();
		}
		
		public static function UnlockLevel(i:int):void
		{
			if (data.LevelsUnlocked < i)
			{
				data.LevelsUnlocked = i;
				so.flush();
			}
		}
		
		public static function GetData():Object
		{
			return data;
		}
		
		public static function SetData(s:Object):void
		{
			data = s;
		}
		
	}

}