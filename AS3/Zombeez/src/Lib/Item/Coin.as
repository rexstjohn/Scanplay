package Lib.Item 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import Lib.GameEvent.GameEvent;
	import Lib.Item.Item;
	import Lib.Sound.SoundFactory;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class Coin extends Item
	{
		public var dispatcher:EventDispatcher;
		
		public function Coin() 
		{
			super("Coin");
			dispatcher = new EventDispatcher();
			sf = new SoundFactory();
		}
		
		public function onCoinDrop():void
		{
			sf.playSound("CoinSound");
			var shrinkRate:Number = .02;
			var shrink:Number = 1;
			scaleX = .25;
			scaleY = .25;
			
			addEventListener(Event.ENTER_FRAME, shrinkCoin);
			
			function shrinkCoin(e:Event):void
			{
				scaleX = shrink;
				scaleY = shrink;
				shrink -= shrinkRate;				
				alpha = shrink;
				y -= 10;
				
				if (shrink <= .2)
				{
					removeEventListener(Event.ENTER_FRAME, shrinkCoin);
					
					var g:Event = new Event("Update");
					dispatcher.dispatchEvent(g);
				}
			}
			
		}
		
	}

}