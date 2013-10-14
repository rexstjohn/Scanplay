package com.game.blocks.crates
{
	import Box2D.Collision.Shapes.b2MassData;
	import com.physics.blocks.Block2D;
	import com.game.ship.weapon.Weapon;
	import flash.geom.Point;
	import com.physics.GameWorld;
	import com.game.GameObject;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * A special block that other items gravitate towards. Requires a custom controller.
	 */
	public class MagnetBlock extends Block2D
	{
		
		public function MagnetBlock(_p:Point) 
		{
			super(_p, "MagnetBlock", 0, "undefined",  false,500);
			SetAsIndestructable();
			
			GameWorld.gravityWellController.AddGravityBlock(this);
			var mass:b2MassData = new b2MassData();
			mass.mass = 50;
			body.SetMassData(mass);
			points = 0;
		}
	}
}