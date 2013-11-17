package Lib.Item 
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import Lib.GameEvent.InventoryEvent;
	import Lib.GameEvent.StoreEvent;
	import Lib.GameObject;
	/**
	 * ...
	 * @author Rex
	 */
	public class StoreItem extends Item
	{
		public var itemCost:int;
		
		public var Price:*;
		public var Label:*;
		public var BuyItem:SimpleButton;
		public var Message:TextField;
		
		public var Coin:MovieClip;
				
		public function StoreItem()
		{			
			super("StoreItem");
		}
		
		public function init(n:String, c:int, t:String, mx:int, ac:int, ip:Boolean):void
		{
			itemType = t;
			itemCost = c;			
			itemName = n;
			maxQuantity = mx;
			currentQuantity = mx;
			ammoCost = ac;
			isPremium = ip;
			
			buttonMode = true;
			Name = n;
			Label.text = itemName;
			
			BuyItem.visible = false;
			Message.visible = false;			
			Coin.visible = true;
			Price.visible = true;
			
			gotoAndStop(Name);
			
			Price.text = String(itemCost);
			
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(MouseEvent.MOUSE_OVER, onOver);
			addEventListener(MouseEvent.MOUSE_OUT, onOut);
		}		
		
		public function onClick(e:MouseEvent):void
		{			
			switch(e.target.name)
			{
				case "BuyItem":
				var s:StoreEvent = new StoreEvent("BuyItem", this);
				Update(s);
				break;					
			}
		}	
		
		public function onOver(e:MouseEvent):void
		{
			glowRed();
			BuyItem.visible = true;
		}
		
		public function onOut(e:MouseEvent):void
		{
			filters = [];			
			BuyItem.visible = false;
		}
		
		public function onPurchaseSucess():void
		{			
			Message.visible = true;
			Message.text = "Purchased!";
			sf.playSound("CoinSound");
			BuyItem.visible = false;
			alpha = .5;
			mouseEnabled = false;
			mouseChildren = false;
			buttonMode = false;
			stop();
			
			removeEventListener(MouseEvent.CLICK, onClick);
			removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			removeEventListener(MouseEvent.MOUSE_OUT, onOut);
		}
		
		public function onPurchaseFailure():void
		{			
			Message.visible = false;
			Message.text = "Can't Afford It!";
			BuyItem.visible = false;
			sf.playSound("FailSound");
		}
		
		public function Update(e:StoreEvent):void
		{
			d.dispatchEvent(e);
		}
		
		
	}
}