package com.game.fx 
{
	import com.core.factory.AssetFactory;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class WaveSplash extends MovieClip
	{
		private var sprite:Sprite;
		private var state:String = "Idle";
		private var wave:MovieClip;
		
		public function WaveSplash() 
		{
			super();
			sprite = AssetFactory.GetSprite("WaveSplash");
			wave = (MovieClip (MovieClip(sprite).getChildAt(0)));
			addChild(wave);
			
			x = 700;
			y = 600;
			
			addEventListener(Event.ENTER_FRAME, handleEnter);
		}
		
		public function handleEnter(e:Event):void
		{
			if (wave.currentFrame == (wave.totalFrames - 1))
			{
				wave.stop();
				state == "Stopped";
				wave.gotoAndStop(1);
			}
		}
		
		public function Play():void
		{
			state = "Playing";
			wave.play();
		}
	}

}