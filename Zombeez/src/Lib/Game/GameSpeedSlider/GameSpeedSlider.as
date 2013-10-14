package Lib.Game.GameSpeedSlider 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import Lib.GameObject;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class GameSpeedSlider extends GameObject
	{
		public var speedPercentage:Number;
		public var Slider:MovieClip;
		public var mouseIsDown:Boolean = false;
		public var difficulty:String = "Normal";
		
		public function GameSpeedSlider() 
		{
			super("GameSpeedSlider");
			Name = "GameSpeedSlider";
		}
		
		public function init():void
		{
			speedPercentage = .50;
			difficulty = "Normal";
			Slider.x = width * speedPercentage;
			mouseEnabled = true;
			addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			addEventListener(MouseEvent.MOUSE_UP, onUp);
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		public function onDown(e:MouseEvent):void
		{
			mouseIsDown = true;
		}
		
		public function onUp(e:MouseEvent):void
		{
			mouseIsDown = false;
		}
		
		public function onClick(e:MouseEvent):void
		{
			trace(Slider.x);
			Slider.x = e.stageX - 120;		
			speedPercentage = (Slider.x / width);
			sf.playSound("ClickSound");
		
			
			//set the game difficulty based on the slider posiution
			if (speedPercentage >= .7)
			{
				difficulty = "Hardest";
			}
			
			if (speedPercentage <= .7)
			{
				difficulty = "Hard";
			}
			
			if (speedPercentage <= .5)
			{
				difficulty = "Normal";
			}
			
			if (speedPercentage <= .33)
			{
				difficulty = "Easy";
			}
		}
	}

}