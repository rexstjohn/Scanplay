package Lib.GameEvent 
{
	import Lib.Level.Level;
	import flash.events.Event;
	/**
	 * ...
	 * @author Rex
	 */
	public class LevelEvent extends GameEvent
	{
		public var level:Level;
		
		public function LevelEvent(c:String, l:Level) 
		{
			super("Update");
			command = c;
			level = l;
		}
		
	}

}