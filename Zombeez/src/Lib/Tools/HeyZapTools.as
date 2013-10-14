package Lib.Tools 
{
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	import flash.display.DisplayObject;
	import heyzap.as3.HeyzapTools;
	
	public class HeyZapTools
	{
		public var zapKey:String;
		public var surface:DisplayObject;
		
		public function HeyZapTools(zk:String, roote:DisplayObject) 
		{
			zapKey = zk;
			surface = roote;
		}
		
		public function connect():void
		{
			trace("HeyZap::Connecting");
			HeyzapTools.load({game_key: zapKey, clip: surface});
		}
		
	}

}