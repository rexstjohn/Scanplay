package com.physics.events
{
	import com.core.interfaces.IEvent;
	import flash.events.Event;

	public class PhysicsStoppedEvent extends PhysicsEvent
	{
		public function PhysicsStoppedEvent()
		{
			super(PHYSICS_STOPPED_EVENT);
		}
		
	}
}