package Lib.GameEvent 
{
	import flash.events.Event;
	import Lib.Achievement.Achievement;
	
	/**
	 * ...
	 * @author Rex
	 */
	public class AchievementEvent extends Event
	{
		public var command:String;
		public var achievement:Achievement;
		
		public function AchievementEvent(c:String, a:Achievement) 
		{
			super("Update");
			command = c;
			achievement = a;
		}
		
	}

}