package Lib.Player 
{
	import Lib.GameObject;
	import flash.events.*;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class PlayerDeath extends GameObject
	{
		
		public function PlayerDeath() 
		{
			super("PlayerDeath");
		}
		
		public function init():void
		{
			Name = "PlayerDeath";		
			gotoAndStop(1);	
			addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		public function onEnter(e:Event):void
		{
			if (currentLabel == "Dead")
			{
				stop();
				removeEventListener(Event.ENTER_FRAME, onEnter);
			}
		}
	}

}