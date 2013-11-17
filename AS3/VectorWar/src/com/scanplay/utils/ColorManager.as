package com.scanplay.utils 
{
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class ColorManager
	{		
		//filters
		public var yellowGlowFilter:GlowFilter = new GlowFilter(0xFFFF00,25,25,25,2,2,false,false);
		public var redGlowFilter:GlowFilter = new GlowFilter(0xFF0000, 25, 25, 25, 2, 2, false, false);
		public var greenGlowFilter:GlowFilter = new GlowFilter(0x00CD00, 25, 25, 25, 2, 2, false, false);
		
		private var colorObject:MovieClip;
		private var originalFilter:ColorTransform;
		
		public var glowing:Boolean = false;
		
		public function ColorManager(obj:MovieClip)
		{
			colorObject = obj;		
			originalFilter = colorObject.transform.colorTransform; //save the original state
		}
		
		public function glow(c:String):void
		{		
			switch(c)
			{
				case "Red":
					colorObject.filters = [redGlowFilter];
					glowing = true;
					break;
				case "Green":
					colorObject.filters = [greenGlowFilter];
					glowing = true;
					break;
				case "Yellow":
					colorObject.filters = [yellowGlowFilter];
					glowing = true;
					break;
				default:
					trace("ColorManager:: No Color Selected");
					break;
			}
		}
		
		//function for flashing red
		public function flashRed():void
		{						
			//red transform
			var colorTransform:ColorTransform = colorObject.transform.colorTransform;
			colorTransform.color = 0xFF0000;
			colorObject.transform.colorTransform = colorTransform;			
			
			var flashTimer:Timer = new Timer(100);
			flashTimer.addEventListener("timer", onFlash);
			flashTimer.start();
			
			function onFlash(e:TimerEvent):void
			{
				colorObject.transform.colorTransform = originalFilter;
				flashTimer.stop();
			}
			
		}
		
		//change to a specific color
		public function changeColor(cn:String):void
		{
			var colorTransform:ColorTransform = colorObject.transform.colorTransform;
	
			switch(cn)
			{
				case "Red":
					colorTransform.color = 0xFF0000;
					break;
				case "Green":
					colorTransform.color = 0x00CD00;
					break;
				case "Yellow":
					colorTransform.color = 0xFFFF00;
					break;
				case "Blue":
					colorTransform.color = 0x7B68EE;
					break;
				case "Purple":
					colorTransform.color = 0x8B008B;
					break;
			}			
			
			colorObject.transform.colorTransform = colorTransform;	
			originalFilter = colorTransform;
		}
		
		//function for turning red
		public function turnRed():void
		{
			var colorTransform:ColorTransform =colorObject.transform.colorTransform;
			colorTransform.color = 0xFF0000;
			colorObject.transform.colorTransform = colorTransform;
		}	
		
		//reset the filter back to normal
		public function clearFilters():void
		{
			colorObject.filters = [];
			colorObject.transform.colorTransform = originalFilter;
			glowing = false;
		}
	}

}