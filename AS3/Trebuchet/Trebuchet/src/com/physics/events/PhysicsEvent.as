package com.physics.events
{
	import com.core.interfaces.IEvent;
	
	import flash.events.Event;

	public class PhysicsEvent extends Event implements IEvent
	{
		public static var PHYSICS_STARTED_EVENT:String = "physics started";
		public static var PHYSICS_STOPPED_EVENT:String = "physics stopped";
		
		public function PhysicsEvent(type:String)
		{
			super(type, false, false);
		}
	}
}