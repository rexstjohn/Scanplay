package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import Level.LevelLoader;
	import Unit.*;
	import heyzap.as3.HeyzapTools;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class Main extends Sprite 
	{
		//game interface
		public var levelLoader:LevelLoader;
		
		public function Main():void 
		{			
			HeyzapTools.load( { game_key: "f70c88edbfe696300b64e025cf0b1eba", clip: root } );	
						
			init();
			//HeyzapTools.send("showAd");				
			HeyzapTools.addEventListener("adFinished", function (response:Object):void 
			{
				init();
			});				
		}
		
		private function init():void 
		{
			// entry point			
			HeyzapTools.send("trackEvent", { event: "GameStart" } );
			
			//create the player
			levelLoader = new LevelLoader(this);
			
			//galaxy.show();
			levelLoader.loadLevel(1);
		}
		
		private function Update():void
		{
		}
	}
	
}