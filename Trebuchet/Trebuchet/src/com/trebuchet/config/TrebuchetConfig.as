package com.trebuchet.config
{
	import com.core.util.Bounds;

	import flash.geom.Point;

	public class TrebuchetConfig
	{
		public static const DEFAULT_HEIGHT:int = GameConfig.STAGE_HEIGHT - 100;
		public static const DEFAULT_ARM_LENGTH:int = 100;
		public static const DEFAULT_PAYLOAD_WEIGHT:int = 100;
		public static const DEFAULT_ROPE_LENGTH:int = DEFAULT_ARM_LENGTH/4;
		public static const DEFAULT_AMMO_CAPACITY:int = 3;
		public static const DEFAULT_AMMO_TYPE:String = "square wood pellets";
		public static const THROWING_ARMY_THICKNESS:int = 10;

		//sizes
		public static const COUNTER_WEIGHT_DIMENSIONS:Bounds = new Bounds(25,25);

		//ammo types
	}
}

