package Lib.GameInterface 
{
	import flash.events.EventDispatcher;
	import flash.text.TextField;
	import Lib.Game.GameInventory.GameInventory;
	import Lib.GameEvent.GameEvent;
	import Lib.GameObject;
	import Lib.Player.Player;
	import Lib.Sound.SoundFactory;
	
	/**
	 * ...
	 * @author Rex
	 */
	public class GameInterface extends GameObject
	{
		public var player:Player;
		
		public function GameInterface() 
		{
			super("Interface");
			d = new EventDispatcher();
			visible = false;
		}
		
		public function Update(c:String):void
		{
			trace("Interface::" + Name + "::SendingUpdate::" +c);
			var g:GameEvent = new GameEvent(c);			
			d.dispatchEvent(g);
		}
		
	}

}