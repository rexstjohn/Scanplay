package com.game.blocks.polygons
{
	import com.physics.blocks.Polygon2D;
	import com.physics.controllers.GravityWell;
	import com.physics.GameWorld;
	import Box2D.Collision.Shapes.b2MassData;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class GravityPolygon extends Polygon2D
	{
		
		public function GravityPolygon(_points:Array) 
		{
			super(_points, "MagnetBlock");
			
			GameWorld.gravityWellController.AddGravityBlock(this);
			var mass:b2MassData = new b2MassData();
			mass.mass = 50;
			body.SetMassData(mass);
		}		
	}
}