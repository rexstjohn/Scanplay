package Lib.Game.GameBackground 
{
	import Lib.GameObject;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class GameBackground extends GameObject
	{
		
		public function GameBackground() 
		{
			super("GameBackground");	
		}
		
		public function changeBackground(bg:String):void
		{
			trace("current label" + currentLabel);
			gotoAndStop(bg);
		}
	}

}