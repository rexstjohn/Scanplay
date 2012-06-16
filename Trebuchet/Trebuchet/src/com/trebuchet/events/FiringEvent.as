package com.trebuchet.events
{
	import com.core.interfaces.IPhysicsObject;
	import com.core.prefab.Prefab;

	public class FiringEvent extends GameEvent
	{
		private var _projectile:IPhysicsObject;
		private var _weapon:Prefab;

		public function FiringEvent(_projectile:IPhysicsObject,_weapon:Prefab)
		{
			super(FIRING_EVENT);
			this._projectile = _projectile;
			this._weapon = _weapon;
		}

		public function get projectile():IPhysicsObject{return _projectile;}
		public function get weapon():Prefab{return _weapon;}
	}
}

