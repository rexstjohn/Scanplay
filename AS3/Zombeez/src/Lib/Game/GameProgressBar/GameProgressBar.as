package Lib.Game.GameProgressBar 
{
	import flash.display.MovieClip;
	import Lib.GameObject;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class GameProgressBar extends GameObject
	{		
		public var zombieCountInLevel:int;
		public var percentageLeft:Number;
		public var zombiesLeft:int;
		public var gameStage:String;
		
		public var Progress:MovieClip;
		public var startingWidthPB:Number;
		public var Skull:MovieClip;
		public var RedBox:MovieClip;
		
		public function GameProgressBar() 
		{
			super("GameProgressBar");			
		}
		
		public function init(zCount:int):void
		{
			gameStage = "Start";
			percentageLeft = 100;
			zombieCountInLevel = zCount;
			Progress.width = 189;
			Skull.filters = [];
			RedBox.visible = true;
			startingWidthPB = Progress.width;
		}
		
		public function updateKillProgress(killCount:int):void
		{
			zombiesLeft = (zombieCountInLevel - killCount);
			percentageLeft = (zombiesLeft / zombieCountInLevel);
			Progress.width = (percentageLeft * startingWidthPB);
			
			trace("GameProgressBar::Percent Left In Game" + percentageLeft);
			
			if (percentageLeft <= .15)
			{				
				gameStage = "FinalRush";
				Skull.filters = [redGlowFilter];
				RedBox.visible = false;
			}
		}
		
	}

}