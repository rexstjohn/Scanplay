package com.core
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	impor
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Main extends Sprite 
	{
		protected static var sprite:Sprite;
		protected static var _stage:Stage;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			sprite = new Sprite();
			addChild(sprite);
			
			_stage = stage;
		
			addEventListener(Event.ENTER_FRAME, Update);
		}
		
		private static function Update(e:Event):void
		{}
		
		public static function GetSprite():Sprite
		{
			return sprite;
		}
		
		public static function GetStage():Stage
		{
			return _stage;
		}
	}
	
}