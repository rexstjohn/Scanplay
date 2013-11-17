package Lib.Player 
{
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Lib.GameEvent.GameEvent;
	import Lib.GameObject;
	import Lib.Item.InventoryItem;
	import Lib.Item.Item;
	import Lib.Level.Level;
	import Lib.Item.StoreItem;
	import Lib.Weapon.FlameThrower;
	import Lib.Weapon.NitroGun;
	import Lib.Weapon.Pistol;
	import Lib.Weapon.ShotGun;
	import Lib.Weapon.Weapon;
	/**
	 * ...
	 * @author Rex
	 */
	public class Player extends GameObject
	{		
		public var items:Array;//inventory		
		public var achievements:Array;//achievements
		public var levels:Array; //levels the player owns / has beaten
		
		//stats
		public var Kills:int = 0;
		public var Coins:int = 0;
		public var LevelsBeaten:int = 1;		
		public var currentLevel:Level;
		public var health:int;
		
		//weapons
		public var weapons:Array;
		
		//player stats
		public var death:PlayerDeath;
		
		public var shotGun:ShotGun;
		public var pistol:Pistol;
		public var flameThrower:FlameThrower;
		public var nitroGun:NitroGun;
		
		//target player is aiming at
		public var targetX:int;
		public var targetY:int;
		public var currentWeapon:Weapon;
		
		public function Player() 
		{
			super("Player");
			Name = "Player";
			items = new Array();
			achievements = new Array();
			weapons = new Array();
			
		}
		
		public function init():void
		{			
			weapons = new Array();
			health = 220;
						
			//set up the weapons
			pistol.init();
			shotGun.init();
			flameThrower.init();
			nitroGun.init();
			death.init();
			
			weapons.push(shotGun);
			weapons.push(pistol);
			weapons.push(flameThrower);
			weapons.push(nitroGun);
			
			shotGun.visible = false;
			flameThrower.visible = false;
			nitroGun.visible = false;
			death.visible = false;
			
			currentWeapon = pistol;
			
			addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		public function onEnter(e:Event):void
		{
			if (health <= 0)
			{
				removeEventListener(Event.ENTER_FRAME, onEnter);
				currentWeapon.unEquip();				
				death.visible = true;
				death.gotoAndPlay(1);
			}
		}
		
		public function changeWeapon(weaponItem:InventoryItem):void
		{
			trace("Player::Changing Weapon::" + weaponItem.itemName);
			for (var g:int = 0; g < items.length; g++)
			{			
				if (items[g].itemName == weaponItem.itemName)
				{
					for (var l:int = 0; l < weapons.length; l++)
					{
						if (weapons[l].weaponName == weaponItem.itemName)
						{
							//get weapon from weapons array by name
							trace("setting equip::" + items[g].itemName);
							weapons[l].equip();
							currentWeapon = weapons[l];
							currentWeapon.weaponItem = weaponItem;
						}
						else
						{
							trace("setting unequip::" + weapons[l]);
							weapons[l].unEquip();
						}
					}
				}				
			}
		}
				
		//check if the player owns the item, if they can afford it, if they can have more than one of it
		public function playerCanBuyItem(i:StoreItem):Boolean
		{
			var playerCanHave:Boolean = false;
			
			if (Coins >= i.itemCost)
			{				
				if (i.itemType != "Weapon")
				{
					playerCanHave = true;
				}				
				else if (!playerHasItem(i))
				{	
					playerCanHave = true;
				}				
			}
			
			return playerCanHave;
		}
		
		public function getItemIndex(i:StoreItem):int
		{
			var index:int = 0;
			
			for (var g:int = 0; g < items.length; g++)
			{
				if (items[g].itemName == i.itemName)
				{
					index = g;
				}
			}
			
			return g;
		}
		
		public function playerHasItem(i:StoreItem):Boolean
		{
			var isInInventory:Boolean = false;
			
			for (var g:int = 0; g < items.length; g++)
			{
				if (items[g].itemName == i.itemName)
				{
					isInInventory = true;
				}
			}
			
			return isInInventory;
		}
		
		public function getWeapons():Array
		{
			var weaponsArray:Array = new Array();
			
			for (var g:int = 0; g < items.length; g++)
			{
				if (items[g].itemType == "Weapon")
				{
					weaponsArray.push(items[g]);
				}
			}			
			return weaponsArray;
		}

		public function getWeaponsAndPowerUps():Array
		{
			var weaponsAndPowerUps:Array = new Array();
			
			for (var g:int = 0; g < items.length; g++)
			{
				if (items[g].itemType == "Weapon")
				{
					weaponsAndPowerUps.push(items[g]);
				}
				if (items[g].itemType == "PowerUp")
				{
					weaponsAndPowerUps.push(items[g]);					
				}
			}			
			return weaponsAndPowerUps;
		}
		
		public function getPowerUps():Array
		{
			var powerups:Array = new Array();
			
			for (var g:int = 0; g < items.length; g++)
			{
				if (items[g].itemType == "PowerUp")
				{
					powerups.push(items[g]);
				}
			}			
			return powerups;
		}
		
		public function handleMoves(e:MouseEvent):void
		{
			targetX = e.stageX;
			targetY = e.stageY;	
			currentWeapon.aimWeapon(targetX, targetY);		
		}
		
		public function handleClicks(e:MouseEvent):void
		{
			currentWeapon.handleClicks(e);			
		}
		
		public function Update(argument:String):void
		{
			var g:GameEvent = new GameEvent("Update");
			g.argument = argument;
			d.dispatchEvent(g);
		}
	}

}