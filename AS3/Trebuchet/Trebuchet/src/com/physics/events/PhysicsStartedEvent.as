package com.physics.events
{
	import com.core.interfaces.IEvent;

	public class PhysicsStartedEvent extends PhysicsEvent
	{
		public function PhysicsStartedEvent()
		{
			super(PHYSICS_STARTED_EVENT);
		}
		
	}
}