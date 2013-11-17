package Lib.Item 
{
	import flash.text.TextField;
	import Lib.GameEvent.InventoryEvent;
	import Lib.Item.Item;
	import flash.display.*;
	import flash.events.*;
	import Lib.GameEvent.StoreEvent;
	import Lib.Player.Player;
	import Lib.Sound.SoundFactory;
	import Lib.Weapon.Weapon;
	
	/**
	 * ...
	 * @author ...
	 * 
	 * This is an item that appears in the player's inventory.
	 */
	public class InventoryItem extends Item
	{
		public var AmmoBar:MovieClip = new MovieClip();
		public var initialAmmoBarWidth:int = 64;
		
		public var clipSize:int = 0;
		public var ammoLeft:int = 0;
		public var costToRefill:int = 0;
		
		public var selected:Boolean = false;
		public var player:Player;
		
		//stuff related to refilling ammo
		public var RefillWeaponAmmo:MovieClip = new MovieClip();
		public var RefillCost:TextField = new TextField();
		public var ReloadArrow:MovieClip = new MovieClip();
		
		public function InventoryItem() 
		{
			super("InventoryItem");			
		}
		
		public function init(weapon:StoreItem, p:Player):void
		{	
			trace("init game mode::" + weapon.itemName);			
			itemName = weapon.itemName;					
			costToRefill = weapon.ammoCost;
			player = p;
			sf = new SoundFactory();
			
			buttonMode = true;
			Name = itemName;	
			alpha = 1;
			
			//make the ammo refill stuff invisible
			RefillWeaponAmmo.visible = false;
			
			//set the ammo bar
			ammoLeft = weapon.maxQuantity;
			clipSize = weapon.maxQuantity;
			RefillWeaponAmmo.mouseChildren = false;
			ReloadArrow.visible = false;
			
			gotoAndStop(Name);
			
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(MouseEvent.MOUSE_OVER, onOver);
			addEventListener(MouseEvent.MOUSE_OUT, onOut);
			addEventListener(Event.ENTER_FRAME, onEnter);
		}		
		
		//sets an inventory slot to a blank state.
		public function setAsBlank():void
		{
			trace("InventoryItem::SettingAsBlank");
			itemName = "Blank";			
			Name = "Blank";	
			alpha = .5;				
			gotoAndStop(Name);
			RefillWeaponAmmo.visible = false;
			ReloadArrow.visible = false;
		}
		
		//refill the ammo (if the player has enough money) or select the weapon if it is selectable
		public function onClick(e:MouseEvent):void
		{			
			if (ammoLeft > 0)
			{
				trace("InventoryItem::Click::" + Name);		
				onSelectedSuccess();
				sf.playSound("ChangeWeaponSound");
				var s:InventoryEvent = new InventoryEvent("SelectItem", this);
				Update(s);			
			}
			
			if (ammoLeft <= 0)
			{
				if (player.Coins >= costToRefill)
				{
					ammoLeft = clipSize;
					AmmoBar.width = initialAmmoBarWidth * (ammoLeft / clipSize);
					alpha = 1;
					RefillWeaponAmmo.visible = false;
					sf.playSound("CoinSound");
					player.Coins -= costToRefill;
					var j:InventoryEvent = new InventoryEvent("RefillAmmo", this);
					player.Update("UpdateCoins");
					ReloadArrow.visible = false;
					Update(j);			
				}
				else
				{					
					sf.playSound("FailSound");
				}
			}
		}	
		
		public function onEnter(e:Event):void
		{
			if (ammoLeft <= 0)
			{
				RefillWeaponAmmo.visible = true;				
				alpha = .5;
				ReloadArrow.visible = true;
				RefillWeaponAmmo.RefillCost.text = String(costToRefill);
			}
		}
		public function onOver(e:MouseEvent):void
		{
			glowRed();
		}
		
		public function onOut(e:MouseEvent):void
		{
			if (!selected)
			{
				filters = [];		
			}
		}
		
		public function onSelectedSuccess():void
		{			
			glowRed();
			selected = true;
		}
		
		public function onDeselect():void
		{			
			filters = [];		
			selected = false;
		}
		
		public function reset():void
		{
			AmmoBar.width = initialAmmoBarWidth;
		}
		
		public function decreaseAmmo():void
		{
			ammoLeft--;
			AmmoBar.width = initialAmmoBarWidth * (ammoLeft / clipSize);
		}
		
		public function Update(e:InventoryEvent):void
		{
			d.dispatchEvent(e);
		}
		
	}

}