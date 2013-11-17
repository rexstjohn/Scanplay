package Lib.GameInterface 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import Lib.GameInterface.GameInterface;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Instructions extends GameInterface
	{
		public var instructions:MovieClip;
		public var BackToMap:SimpleButton;
		public var NextButton:SimpleButton;
		public var BackButton:SimpleButton;
		
		public function Instructions() 
		{
			super();
			
		}
		
		public function init():void
		{
			Name = "Instructions";
			stop();
			addEventListener(MouseEvent.CLICK, onClick);			
		}
		
		public function onClick(e:MouseEvent):void
		{
			sf.playSound("ClickSound");
			switch(e.target.name)
			{
				case "BackButton":
					gotoAndStop(currentFrame - 1);
					break;
				case "NextButton":
					gotoAndStop(currentFrame + 1);
					break;
				case "BackToMap":
					gotoAndStop(1);
					Update("LoadMap");
					break;
			}
		}		
	}

}