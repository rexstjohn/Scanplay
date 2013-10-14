package Lib.Game 
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;
	import Lib.Game.Creature.CreatureFactory;
	import Lib.Game.GameInventory.GameInventory;
	import Lib.Game.GameProgressBar.GameProgressBar;
	import Lib.Game.GameSpeedSlider.GameSpeedSlider;
	import Lib.Game.HealthBar.HealthBar;
	import Lib.GameEvent.*;
	import Lib.GameInterface.Game;
	import Lib.GameLoader.GameLoader;
	import Lib.Level.Level;
	import Lib.Player.Player;
	import Lib.Item.*;
	import com.scanplay.utils.getRandom;
	import Lib.GameObject
	/**
	 * ...
	 * @author Rex
	 */
	public class GameModel extends EventDispatcher
	{
		public var level:Level;		
		public var stage:Stage;
		public var gameKills:int; 
		
		public var player:Player;
		public var inventory:Array;
		public var healthBar:HealthBar;
		
		public var cf:CreatureFactory;
		public var creatures:Array;
		public var creatureCount:int;
		
		public var ProgressBar:GameProgressBar;		
		public var selectedInventoryItem:InventoryItem;		
		public var SpeedSlider:GameSpeedSlider;
		
		//text fields
		public var CoinsLeft:TextField;
		
		public var gameOver:Boolean = false;
		
		public function GameModel(p:Player) 
		{
			player = p;			
		}
		
		public function init(game:Game):void
		{			
			//init important objects / reset objects
			stage = game.stage;
			level = player.currentLevel; //import the level info
			
			//get the textfield for coins the player has left
			CoinsLeft = game.CoinsLeft;
			CoinsLeft.text = String(player.Coins);
			
			creatureCount = level.creatureCount; //init the progress bar	/ level progress bar via kills		
			ProgressBar = game.ProgressBar;
			ProgressBar.init(creatureCount);
			
			//init the lose / win overlays
			game.YouLose.gotoAndStop(1);
			game.YouWin.gotoAndStop(1);
			
			creatures = new Array();
			cf = new CreatureFactory();
			selectedInventoryItem = new InventoryItem();
			
			//set the level number
			 var myPattern:RegExp = /Level/;			 
			game.LevelNumber.text = String(level.Name.replace(myPattern, ""));
			
			//set the kills
			game.KillNumber.text = String(0);
			
			//set the time
			game.Time.text = String(0);
			
			//get the game speed
			SpeedSlider = game.SpeedSlider;
			SpeedSlider.init();
			
			//set back to map invisible
			game.BackToMap.visible = false;	
			game.YouWinTheGame.visible = false;
			player.visible = true;
			
			trace("GameModel::Adding the Player");			
			stage.addChild(player);
			player.x = 150;
			player.y = 400;
			player.init();
			healthBar = game.healthBar;
			healthBar.width = player.health;
			
			trace("GameModel::Initializing Level::" + level.backgroundName);
			game.Background.gotoAndStop(level.backgroundName);
			creatureCount = level.creatureCount;
			
			trace("GameModel::Initializing Inventory");
			inventory = new Array();
			
			var Slot1:InventoryItem = 	game.Slot1;
			var Slot2:InventoryItem = 	game.Slot2;
			var Slot3:InventoryItem = 	game.Slot3;
			var Slot4:InventoryItem = 	game.Slot4;
			var Slot5:InventoryItem = 	game.Slot5;
			
			inventory.push(Slot1);
			inventory.push(Slot2);
			inventory.push(Slot3);
			inventory.push(Slot4);
			inventory.push(Slot5);		
			
			//set them all to blank first
			for (var h:int = 0; h < inventory.length; h++)
			{
				inventory[h].setAsBlank();
				inventory[h].mouseEnabled = true;
			}
			
			//populate the inventory with weapons
			var weapons:Array = player.getWeapons();			
			var inventoryIndex:int = 0;
			
			for (var k:int  = 0; k < weapons.length; k++)				
			{				
				inventory[inventoryIndex].init(weapons[k], player);
				inventory[inventoryIndex].reset();
				inventory[inventoryIndex].d.addEventListener("Update", onInventoryItemUpdate);
				inventoryIndex++;
				
				//have the player equip the pistol to begin with
				if (inventory[inventoryIndex].itemName == "Pistol")
				{					
					player.changeWeapon(inventory[inventoryIndex]);
				}
			}
			
			//begin the game start countdown			
			game.CountDown.gotoAndPlay(1);
		}		
		
		public function destroy():void
		{
			for (var d:* in player.currentWeapon.projectiles)
			{
				stage.removeChild(player.currentWeapon.projectiles[d]);
				player.currentWeapon.projectiles.splice(d, 1);
			}			
			
			stage.removeChild(player);			
			removeAllZombies();
			
			for (var k:* in inventory)
			{
				inventory[k].reset();
			}
			
		}
		
		public function removeAllZombies():void
		{
			for (var i:* in creatures)
			{
				for (var k:* in creatures[i].projectiles)
				{
					if (stage.contains(creatures[i].projectiles[k]))
					{
						stage.removeChild(creatures[i].projectiles[k]);
					}		
					if (creatures[i].contains(creatures[i].projectiles[k]))
					{
						creatures[i].removeChild(creatures[i].projectiles[k]);
					}	
					
				}
				if (stage.contains(creatures[i]))
				{
					stage.removeChild(creatures[i]);
				}
			}
		}
		
		public function equipPistol():void
		{
			for (var g:int = 0; g < inventory.length; g++)
			{
				if (inventory[g].Name == "Pistol")
				{			
					var evt:InventoryEvent = new InventoryEvent("SelectItem", inventory[g]);
					onInventoryItemUpdate(evt)
				}
			}
		}
		
		public function onInventoryItemUpdate(e:InventoryEvent):void
		{
			trace("GameModel::Inventory Event:" + e.command);
			switch(e.command)
			{
				case "SelectItem":
					player.changeWeapon(e.inventoryItem);
					selectedInventoryItem = e.inventoryItem;
					selectedInventoryItem.onSelectedSuccess();
					
					for (var g:int = 0; g < inventory.length; g++)
					{
						if (inventory[g] != e.inventoryItem)
						{
							inventory[g].onDeselect();
						}
					}
					break;
				case "RefillAmmo":
					CoinsLeft.text = String(player.Coins);
					player.Update("UpdateCoins");
					break;
			}
		}
		
		public function createCreature():void
		{
			trace("GameModel::Adding Creature To Stage");
			creatures.push(cf.getConstrainedRandomCreature(level.maxCreatureLevel));		
			
			//we have to make sure that zombies of the same type aren't spawned mirror image on top of one another
			//that means we need to offset starting animatino frame and x position randomly
			creatures[creatures.length - 1].x -= getRandom(200, 100);	
			creatures[creatures.length - 1].gotoAndPlay(getRandom(10, 1));
			
			stage.addChild(creatures[creatures.length - 1]); 
			creatureCount--;			
			Update("CreatureSpawned");
		}
		
		public function updateCreatureStates():void
		{
			for (var g:* in creatures)
			{		
				if (creatures[g].creatureState == "Destroyed")
				{							
					//check to see if we want to drop a coin
					if (getRandom(100, 1) > 50)
					{
						var c:Coin = new Coin();
						stage.addChild(c);
						c.x = creatures[g].x;
						c.y = creatures[g].y;
						c.onCoinDrop();						
						
						player.Coins += creatures[g].killValue;
						CoinsLeft.text = String(player.Coins);
						player.Update("UpdateCoins");
						
						c.dispatcher.addEventListener("Update", onCoinUpdate);
						
						//make the coin disappear once it is finished animating
						function onCoinUpdate(e:Event):void
						{
							stage.removeChild(c);
						}
					}					
					
					//increment player kills
					player.Kills++;
					player.Update("UpdateKills");
					
					if (stage.contains(creatures[g]))
					{
						stage.removeChild(creatures[g]);
					}
					creatures.splice(g, 1);
					gameKills++;
					Update("CreatureDeath");					
				}			
			}	
		}
		
		public function checkCreatureCollissions():void
		{								
			//check for collissions with the player
			for (var g:* in creatures)
			{		
				if (creatures[g].x <= (player.x))
				{				
					if ((creatures[g].creatureState == "Alive"))
					{		
						player.health -= creatures[g].damage;
						player.sf.playSound("SplatterSound");
						player.flashRed(); // make the zombie flash red
						creatures[g].flashAndDie();				
					}					
				}				
			}	
		}
		
		
		public function checkCreatureProjectileCollissions():void
		{			
			//check for collissions with projectiles that the creatures throw
			for (var b:* in creatures)
			{		
				for (var h:* in creatures[b].projectiles)
				{
					if (creatures[b].projectiles[h].x <= (player.x))
					{
						player.health -= creatures[b].projectiles[h].damage;
						stage.removeChild(creatures[b].projectiles[h]);
						creatures[b].projectiles.splice(h, 1);
					}
				}
			}
		}
		
		public function checkProjectileCollissions():void
		{
			//make sure the array is sorted by x value so that bullets aren't hitting the last zombie before the first zombie etc
			creatures.sortOn("x");
			
			for (var c:* in creatures)
			{
				//check for collissions with the projectiles (bullets) that the player shoots and zombies
				for (var k:* in player.currentWeapon.projectiles)
				{
					//run through the x's and make sure we hit the character with the closest x
					if (creatures[c].creatureState == "Alive")
					{
						//is it a head shot?
						if (isHitting(creatures[c].Head, player.currentWeapon.projectiles[k]))
						{
							trace ("hit" + creatures[c] + " health::" + creatures[c].health);
							creatures[c].damageCreature(player.currentWeapon.projectiles[k].damage * 2);
							stage.removeChild(player.currentWeapon.projectiles[k]);
							player.currentWeapon.projectiles.splice(k, 1);
							break;
						}
						
						//is it a body shot?
						if (isHitting(creatures[c].Body, player.currentWeapon.projectiles[k]))
						{
							trace ("hit" + creatures[c] + " health::" + creatures[c].health);
							creatures[c].damageCreature(player.currentWeapon.projectiles[k].damage);
							stage.removeChild(player.currentWeapon.projectiles[k]);
							player.currentWeapon.projectiles.splice(k, 1);
						}
					}
				}
			}	
			
			function isHitting(obj1:MovieClip, obj2:MovieClip):Boolean
			{
				var isTouching:Boolean = false;
				
				if (obj1.hitTestObject(obj2))
				{isTouching = true; }
				
				return isTouching;
			}
		}
		
		public function updatePlayerHealth():void
		{			
			//update the player's health
			if (player.health <= 0)
			{
				trace("GameModel::PlayerHasDied");
				healthBar.width = 0;
				gameOver = true;
				Update("PlayerDead");
			}		
			healthBar.width = player.health			
		}
		
		//turns off mouse functionality for the UI
		public function disableUI():void
		{
			SpeedSlider.mouseEnabled = false;
			
			for (var g:* in inventory)
			{
				inventory[g].mouseEnabled = false;
				inventory[g].mouseChildren = false;
			}
		}
		
		public function Update(c:String):void
		{
			var g:GameEvent = new GameEvent(c);
			dispatchEvent(g);
		}
		
	}

}