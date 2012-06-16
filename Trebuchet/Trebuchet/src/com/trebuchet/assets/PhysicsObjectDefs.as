package com.trebuchet.assets
{
	import com.physics.PhysicsAttributes;

	public class PhysicsObjectDefs
	{
		//static collection 
		public static var WOOD_BLOCK:PhysicsAttributes = new PhysicsAttributes(Library.WOOD_TEXTURE,"wood",4,1,4,.1 ,PhysicsAttributes.SQUARE_SHAPE,true);
		public static var HEAVY_WOOD_BLOCK:PhysicsAttributes = new PhysicsAttributes(Library.WOOD_TEXTURE,"wood",6,1,6,.1 ,PhysicsAttributes.SQUARE_SHAPE,true);

		//payload definitions
		public static var WOODEN_PELLET:PhysicsAttributes = new PhysicsAttributes(Library.WOOD_TEXTURE,"wood",6,1,6,.1 ,PhysicsAttributes.SQUARE_SHAPE,true);

	}
}

