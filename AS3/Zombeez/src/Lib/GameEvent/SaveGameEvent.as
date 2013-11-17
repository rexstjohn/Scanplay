package Lib.GameEvent 
{
	import flash.events.Event;
	import Lib.SavedGame.SavedGame;
	
	/**
	 * ...
	 * @author Rex
	 */
	public class SaveGameEvent extends Event
	{
		public var command:String;
		public var saveGame:SavedGame;
		
		public function SaveGameEvent(c:String, sg:SavedGame) 
		{
			super("Update");
			command = c;
			saveGame = sg;			
		}		
	}
}