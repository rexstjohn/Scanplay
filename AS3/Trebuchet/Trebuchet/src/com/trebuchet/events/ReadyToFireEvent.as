package com.trebuchet.events
{
	import com.core.interfaces.IPhysicsObject;
	import com.core.prefab.Prefab;

	public class ReadyToFireEvent extends GameEvent
	{
		private var _weapon:Prefab;

		public function ReadyToFireEvent(_weapon:Prefab)
		{
			super(READY_TO_FIRE_EVENT);
			this._weapon = _weapon;
		}

		public function get weapon():Prefab{return _weapon;}
	}
}

