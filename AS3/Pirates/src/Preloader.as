package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Preloader extends MovieClip 
	{
	   [Embed(source = 'com/core/factory/assets/library.swf', symbol = 'Splash')]
       private const _library:Class;
	   private var loader:Sprite;
	   private var rect:Sprite;
	   private var w:Number = 265;
		
		public function Preloader() 
		{
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			// show loader
			loader = Sprite(new _library());
			addChild(loader);			
			
			//create a loading bar
			rect = new Sprite();
			rect.graphics.beginFill(0x760101, 1);
			rect.graphics.drawRect(0, 0, 200, 30);
			rect.graphics.endFill();
			addChild(rect);
			rect.x = 284;
			rect.y = 379;
			loader.x -= 40;
			loader.y += 30;
		}
		
		private function progress(e:ProgressEvent):void 
		{
			// update loader
			rect.width = (e.bytesLoaded  / e.bytesTotal) * w;
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				removeEventListener(Event.ENTER_FRAME, checkFrame);
				startup();
			}
		}
		
		private function startup():void 
		{
			// hide loader
			
			stop();
			removeChild(loader);
			removeChild(rect);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);		
		}		
	}	
}