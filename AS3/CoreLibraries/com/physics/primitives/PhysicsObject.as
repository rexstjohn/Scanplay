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
	public class PhysicsObject extends Sprite
	{
		protected var body:b2Body;
		protected var bodyDef:b2BodyDef;
		protected var fixtureDef:b2FixtureDef;
		protected var boxDef:b2PolygonShape;
		
		public function PhysicsObject() 
		{			
			//create the box definition		
			boxDef                 = new b2PolygonShape();
			bodyDef                = new b2BodyDef();	
			fixtureDef             = new b2FixtureDef();
		}

		public function GetBody():b2Body
		{
			return body;
		}
		
		public function Destroy():void
		{
			World.DestroyBody(body);
		}
		
		public function Update():void
		{
			x = body.GetPosition().x * World.scale;
			y = body.GetPosition().y * World.scale;
			rotation  = body.GetAngle() * (180 / Math.PI);
		}		
	}
}