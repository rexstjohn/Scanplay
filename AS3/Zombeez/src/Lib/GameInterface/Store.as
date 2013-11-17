package Lib.GameInterface 
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;
	import heyzap.as3.HeyzapTools;
	import Lib.GameEvent.*;
	import Lib.GameLoader.GameLoader;
	import Lib.GameInterface.GameInterface;
	import Lib.Player.Player;
	import Lib.SavedGame.SavedGame;
	import Lib.Item.StoreItem;
    import flash.net.*;
	import mochi.as3.*;
	import Lib.Tools.HeyZapTools;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author Rex
	 */
	public class Store extends GameInterface
	{
		public var items:Array;
		
		//text fields
		public var CoinsLeft:TextField;
		public var Message:TextField;		
		public var BackToErnies:SimpleButton;
		
		//store items
		public var Slot1:StoreItem;
		public var Slot2:StoreItem;
		public var Slot3:StoreItem;
		public var Slot4:StoreItem;
	//	public var Slot5:StoreItem;
	
		public var BuyCoins:SimpleButton = new SimpleButton();	
		
		public var Pistol:StoreItem;//Pistol is for the player, get it free
		
		public function Store()
		{
			super();
			Name = "Store"; 
		}
		
		public function init(p:Player):void
		{	
			this.player = p;			
			
			items = new Array();			
			CoinsLeft.text = String(player.Coins);
			
			//var item1:StoreItem = new StoreItem();
			Slot1.init("ShotGun",  2500, "Weapon", 10, 150, false);
			Slot2.init("NitroGun", 3500, "Weapon", 30, 300, false);			
			Slot3.init("FlameThrower",  4000, "Weapon", 30, 400, true);
			Slot4.init("Bang",  4000, "Weapon", 3, 100, true);
			
			Slot3.alpha = .5;
			Slot4.alpha = .5;
			//Slot5.init("HealthPack",  500, "PowerUp");
			
			//the default weapon
			trace("GameStore::Adding Pistol to player's inventory to start");
			Pistol = new StoreItem();
			Pistol.init("Pistol", 0, "Weapon", 25, 50, false);
			player.items.push(Pistol);
			
			//push to array
			items.push(Slot1);
			items.push(Slot2);
			//items.push(Slot3);
			//items.push(Slot4);
			//items.push(Slot5);
			
			items.push(Pistol); //pistol is invisible, but gets put in their inventory
			
			//add listeners and configure the store
			for (var g:int = 0; g < items.length; g++)
			{
				items[g].d.addEventListener("Update", handlePurchase);					
				
				//make purchased weapons invisible							
				if ((items[g].itemType == "Weapon") && player.playerHasItem(items[g]))
				{
					items[g].onPurchaseSucess();				
				}	
				
				//make purchased weapons invisible							
				if ((items[g].itemType == "PowerUp") && player.playerHasItem(items[g]))
				{
					items[g].onPurchaseSucess();				
				}	
			}
				
			addEventListener(MouseEvent.CLICK, onClick);
			player.d.addEventListener("Update", onPlayerUpdate);
		}
		
		public function onPlayerUpdate(e:GameEvent):void
		{
			trace(e.command);
			trace("GameStore::Updating Player::" + e.argument);
			CoinsLeft.text = String(player.Coins);
			
			switch(e.argument)
			{
				case "LoadGame":
					setPlayerItems();
					break;
			}
			
			//resets / sets the player's items after a game is loaded
			function setPlayerItems():void
			{
				trace("GameStore::SettingPlayerItems");
				for (var b:int = 0; b < items.length; b++)
				{
					for (var g:int = 0; g < player.items.length; g++)
					{
						if (items[b].itemName == player.items[g])
						{
							trace("player inventory" + player.items[g]);
							items[b].onPurchaseSucess();
							player.items[g] = items[b];
						}
						else
						{
							items[b].init(items[b].Name, items[b].itemCost, items[b].itemType, items[b].maxQuantity, items[b].ammoCost);
						}
					}
				}
				
				//make sure the player has a pistol, add one if he doesn't
				if (!player.playerHasItem(Pistol))
				{
					player.items.push(Pistol);					
				}
				
				//sort the items to be the correct order
				for (var i:* in player.items)
				{
					
				}
			}
		}
		
		public function onClick(e:MouseEvent):void
		{
			switch(e.target.name)
			{
				case "BackToErnies":
					Update("LoadErnies");
					break;
				case "BuyCoins":
					 //navigateToURL(new URLRequest("http://www.hi5.com"))
					break;
			}
		}
		
		/*
		 * Check if the item is a premium item. If so, open the corresponding toolset item purchase box. Check if the player can own the item (if they dont
		 * own it already and have enough coins to afford it generaly)		 * 
		 */
		
		public function handlePurchase(e:StoreEvent):void
		{
			trace("Store::PlayerBuyingItem::" + e.storeItem.itemName + "::For Price::" + e.storeItem.itemCost);			
			if (e.storeItem.isPremium)
			{
				HeyzapTools.load({game_key: "08f2d3bea26a94f5193ca9b57e677bf8", clip: root});
				HeyzapTools.send("showStore");
			//	HeyzapTools.send("showItem", { item_key: "flame-thrower" } );
				
				Mouse.show();
				HeyzapTools.addEventListener("boughtItem", function (response:Object):void 
				{
				  trace("User bought item: " + response.item.name)
				});
				
				HeyzapTools.addEventListener("boughtItem", function (response:Object):void 
				{
				  trace("User bought item: " + response.item.name)
				});
			}			
			else
			{
				if (player.playerCanBuyItem(e.storeItem)) 
				{
					trace("Store::Purchase Successful");
					mochi.as3.MochiEvents.trackEvent('ItemPurchased'); //track a game completion
					player.items.push(e.storeItem);
					player.Coins -= e.storeItem.itemCost;
					player.Update(null);
					e.storeItem.onPurchaseSucess();	
					Update("AutoSave"); //autosave the game
				}
				else
				{
					trace("Store::Purchase Failed");
					e.storeItem.onPurchaseFailure();
				}
			}
		}
		
	}

}