package com.trebuchet.events
{
	import com.core.interfaces.IPhysicsObject;
	import com.core.prefab.Prefab;

	public class ReloadedEvent extends GameEvent
	{
		private var _lastProjectile:IPhysicsObject;
		private var _weapon:Prefab;

		public function ReloadedEvent(_projectile:IPhysicsObject,_weapon:Prefab)
		{
			super(RELOADED_EVENT);
			this._lastProjectile = _projectile;
			this._weapon = _weapon;
		}

		public function get lastProjectile():IPhysicsObject{return _lastProjectile;}
		public function get weapon():Prefab{return _weapon;}
	}
}

