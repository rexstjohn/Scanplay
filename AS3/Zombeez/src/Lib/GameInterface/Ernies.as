package Lib.GameInterface 
{
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import Lib.GameInterface.GameInterface;
	import Lib.GameEvent.*;
	import Lib.Player.Player;
	
	/**
	 * ...
	 * @author Rex
	 */
	public class Ernies extends GameInterface
	{
		public var CoinsLeft:TextField = new TextField();
		public var StoreOwner:MovieClip = new MovieClip();
		
		public var GoShopping:SimpleButton = new SimpleButton();
		public var BackToMap:SimpleButton = new SimpleButton();
		
		public function Ernies()
		{
			super(); 
		}
		
		public function init(p:Player):void
		{
			player = p;
			Name = "Ernies";
			CoinsLeft.text = String(player.Coins);
			
			addEventListener(MouseEvent.CLICK, onClick);
			player.d.addEventListener("Update", onPlayerUpdate);
		}
		
		public function onPlayerUpdate(e:GameEvent):void
		{
			CoinsLeft.text = String(player.Coins);
		}
		public function onClick(e:MouseEvent):void
		{
			sf.playSound("ClickSound");
			switch(e.target.name)
			{
				case "GoShopping":
					Update("LoadStore");
					break;
				case "GoShoppingCoinStore":
					Update("LoadCoinStore");
					break;
				case "BackToMap":
					Update("LoadMap");
					break;
			}
		}
		
	}

}