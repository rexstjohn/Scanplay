package Lib 
{
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import Lib.GameEvent.GameEvent;
	import flash.filters.*;
    import flash.geom.*;
	import Lib.Sound.SoundFactory;	
	
	/**
	 * ...
	 * @author Rex
	 */
	public class GameObject extends MovieClip
	{
		public var Name:String;
		public var Type:String;
		public var d:EventDispatcher;
		public var sf:SoundFactory;
		
		//standard color transform
		public var colorTrans:ColorTransform;
		
		//filters
		public var yellowGlowFilter:GlowFilter = new GlowFilter(0xFFFF00,25,25,25,2,2,false,false);
		public var redGlowFilter:GlowFilter = new GlowFilter(0xFF0000, 25, 25, 25, 2, 2, false, false);
		public var greenGlowFilter:GlowFilter = new GlowFilter(0x00CD00, 25, 25, 25, 2, 2, false, false);
				
		public function GameObject(t:String) 
		{
			Type = t;			
			d = new EventDispatcher();
			sf = new SoundFactory();
			colorTrans = transform.colorTransform;
		}
		
		public function setPos(xPos:int, yPos:int):void
		{
			this.x = xPos;
			this.y = yPos;
		}
		
		public function glowRed():void
		{
			filters = [redGlowFilter];
		}
		
		public function turnRed():void
		{
			var colorTransform:ColorTransform = this.transform.colorTransform;
			colorTransform.color = 0xFF0000;
			this.transform.colorTransform = colorTransform;
		}	
		
		public function resetColorTransform():void
		{
			transform.colorTransform = colorTrans;
		}
		
		public function flashRed():void
		{						
			//red transform
			var colorTransform:ColorTransform = transform.colorTransform;
			colorTransform.color = 0xFF0000;
			transform.colorTransform = colorTransform;			
			
			var flashTimer:Timer = new Timer(100);
			flashTimer.addEventListener("timer", onFlash);
			flashTimer.start();
			
			function onFlash(e:TimerEvent):void
			{
				transform.colorTransform = colorTrans;
				flashTimer.stop();
			}
			
		}
		
		public function setVisible(v:Boolean):void
		{
			if (v)
			{
				visible = true;
			}
			else
			{
				visible = false;
			}
		}
	}

}