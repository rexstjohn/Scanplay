package com.game.ship 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import com.game.*;
	import com.core.*;
	import com.physics.GameWorld;
	import Box2D.Dynamics.b2Body;
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class Hull extends GameObject
	{
		public var polyShape:b2PolygonShape = new b2PolygonShape();
		
		public function Hull(_length:Number, _depth:Number) 
		{
			super();
						
			var vertices:Array = new Array();
			var vertexCount:int = 4;
			
			//draw the hull
			for ( var g:int = 0; g < vertexCount; g++)
			{
				vertices[g] = new b2Vec2();
			}			
			
			vertices[3].Set((-_length - 20 / 2) / GameWorld.pixels_per_meter, -20 / GameWorld.pixels_per_meter);
			vertices[2].Set((-_length / 2) / GameWorld.pixels_per_meter, (-20 + _depth) / GameWorld.pixels_per_meter);
			vertices[1].Set((_length / 2) / GameWorld.pixels_per_meter, (-20 + _depth) / GameWorld.pixels_per_meter);
			vertices[0].Set((_length + 20 / 2)/ GameWorld.pixels_per_meter, -20 / GameWorld.pixels_per_meter);
			polyShape.SetAsArray( vertices, vertexCount );
			
			
		}
		
	}

}