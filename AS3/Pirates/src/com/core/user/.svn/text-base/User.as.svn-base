package com.core.user 
{
	
	import mochi.as3.*;
	import com.core.Services;
	import com.core.factory.MessageFactory;
	import com.core.GameLevel;
	import com.game.ship.PirateShip;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class User
	{     		
		private static var userData:Object = new Object();
		
		//user properties
		private static var LevelsUnlocked:int = 1;
		private static var LastLevel:int = 1;
		private static var Inventory:Array = new Array();
		private static var isLoggedIn:Boolean = false;
		
		public function User():void
		{}		
		
		public function init(_userData:Object):void
		{
			userData = _userData;
			isLoggedIn = true;
			
			//if the user doesn't have any data, create new data
			if (!userData["LevelsFinished"])
			{
				CreateNewUser();
			}
			else
			{
				LevelsUnlocked = userData["LevelsFinished"];
			}
			
			//update the inventory on purchases
			MochiInventory.addEventListener(MochiInventory.WRITTEN, OnPurchase);
			
			//WipeData();
		}
		
		public static function OnLogOut():void
		{
			isLoggedIn = false;
			LevelsUnlocked = 1;
		}
		
		public static function GetLogInStatus():Boolean
		{
			return isLoggedIn;
		}
		
		//capture the user inventory and dump it into an array we can use in the in-game interface
		public static function SetInventory():void
		{			
			//push all the weapons in from the user's inventory, we will need them in the game
			Inventory.push({ "Key": "Weapon", "WeaponID" : "Cannonball_Rubber",   "ShotsLeft": MochiCoins.inventory.Cannonball_Rubber });
			Inventory.push({ "Key": "Weapon", "WeaponID" : "Cannonball_Explosive",  "ShotsLeft": MochiCoins.inventory.Cannonball_Explosive})
			Inventory.push( { "Key": "Weapon", "WeaponID" : "Cannonball_Triple",     "ShotsLeft": MochiCoins.inventory.Cannonball_Triple } );			
		}
				
		//the ship must check the inventory before it gets permission to fire the cannon
		public static function WeaponCanFire(s:String):Boolean
		{
			var canFire:Boolean  = false;
			
			if (PirateShip.currentWeapon != "Cannonball_Standard")
			{
				if (GetShotsLeft() > 0)
				{
					canFire = true;
				}
				else
				{
					Services.ShowItem(s);
				}					
			}
			else
			{
				canFire = true;
			}
			
			return canFire;
		}
		
		//if  a purchase event is registered, update the inventory		
		public static function OnPurchase(e:*):void
		{
			//push all the weapons in from the user's inventory, we will need them in the game
			Inventory = new Array();
			Inventory.push({ "Key": "Weapon", "WeaponID" : "Cannonball_Explosive",  "ShotsLeft":  (MochiCoins.inventory.Cannonball_Explosive* 10)})
			Inventory.push({ "Key": "Weapon", "WeaponID" : "Cannonball_Triple",     "ShotsLeft":  (MochiCoins.inventory.Cannonball_Triple * 10)} );	
			Inventory.push({ "Key": "Weapon", "WeaponID" : "Cannonball_Rubber",     "ShotsLeft":  (MochiCoins.inventory.Cannonball_Rubber * 10)} );			
		}
		
		public static function GetShotsLeft():int
		{
			var left:int = 0;
			
			for each(var i:Object in Inventory)
			{
				if (i["WeaponID"] == PirateShip.currentWeapon)
				{
					left = int(i["ShotsLeft"]);
				}
			}		
			
			return left;
		}
		
		public static function UseWeapon(s:String):void
		{
			for each(var i:Object in Inventory)
			{
				if (i["WeaponID"] == s)
				{
					if (i["ShotsLeft"] > 0)
					{
						i["ShotsLeft"]--;
					}
				}
			}
		}
				
		public static function GetLevelsUnlocked():int
		{
			return LevelsUnlocked;
		}
		
		public static function UnlockLevel(i:int):void
		{
			if (LevelsUnlocked < i)
			{
				LastLevel = LevelsUnlocked;
				LevelsUnlocked = i;
				
				if (isLoggedIn)
				SaveUserData();
				
				MessageFactory.CreateMessage("Log In To Save Your Progress");
			}
		}	
		
		private static function CreateNewUser():void
		{
			MochiSocial.saveUserProperties({"LevelsFinished": LevelsUnlocked });
		}
		
		public static function SaveUserData():void
		{					
			MochiSocial.saveUserProperties({"LevelsFinished": LevelsUnlocked });
        }
		
		private static function WipeData():void
		{
			userData["LevelsFinished"] = 1;
			SaveUserData();
		}
			
	}

}