package Lib.GameEvent 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Rex
	 */
	public class GameEvent extends Event
	{
		public var command:String;
		public var argument:String;
		
		public function GameEvent(c:String) 
		{
			command = c;
			super("Update");
			
		}
		
	}

}