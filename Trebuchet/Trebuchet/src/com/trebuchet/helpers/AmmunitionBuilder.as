package com.trebuchet.helpers
{
	import com.physics.PhysicsAttributes;
	import com.physics.PhysicsContext;
	import com.physics.PhysicsObject;
	import com.trebuchet.assets.PhysicsObjectDefs;

	import flash.geom.Rectangle;

	public class AmmunitionBuilder
	{
		//ammo types
		public static const WOOD_PELLET:String = "Wood pellet";
		public static const WOOD_LOG:String    = "Wood log";
		public static const TREE_TRUNK:String  = "Tree Trunk";
		public static const IRON_PELLET:String = "Iron pellet";
		public static const ANVIL:String       = "Anvil";
		public static const STONE_PELLET:String= "Stone pellet";
		public static const BOULDER:String     = "Boulder";
		public static const CLUSTER_BOMB:String= "Cluster bomb";
		public static const MAGIC_CAULDRON:String= "Magic cauldron";
		public static const DRAGON_EGG:String  = "Dragon egg";
		public static const DWARVEN_SPHERE:String  = "Dwarven sphere";

		private var _context:PhysicsContext;

		//this builder is used to generate different kinds of ammunition
		public function AmmunitionBuilder(_context:PhysicsContext)
		{
			this._context = _context;
		}

		public function createAmmunitionByType(_type:String, _bounds:Rectangle):PhysicsObject
		{
			//custom ammunition building logic goes here...keep it simple for now (always the same ammo type)
			var attributes:PhysicsAttributes = PhysicsObjectDefs.WOODEN_PELLET;
			attributes.bounds = _bounds;
			return _context.factory.createPhysicsObjectFromAttributes(attributes);
		}
	}
}

