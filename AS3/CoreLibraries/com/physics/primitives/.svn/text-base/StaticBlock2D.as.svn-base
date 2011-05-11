package com.physics.primitives  
{
		import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import com.physics.World;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class StaticBlock2D extends PhysicsObject
	{		
		public function StaticBlock2D(_x:Number, _y:Number, _height:Number, _width:Number) 
		{
			super();
			
			width = _width;
			height = _height;

			//create the boxdef
			boxDef.SetAsBox((_width/ 2) / World.scale, (_height / 2) / World.scale);
			bodyDef.type = b2Body.b2_staticBody;
			
			//set the fixture
			fixtureDef.shape       =  boxDef;
			fixtureDef.density     = .05;
			fixtureDef.friction    = 0.3;
			fixtureDef.restitution = 0.4;
			
			body = World.world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);	
			body.SetPosition(new b2Vec2((_x) / World.scale, (_y ) /  World.scale));
		}
		
	}

}