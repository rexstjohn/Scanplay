package com.physics
{
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	import com.physics.primitives.PhysicsObject;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class World
	{
		public static var world:b2World;
		public static var debugDraw:b2DebugDraw;
		public static var debugSprite:Sprite;
		
		public static var   m_velocityIterations:int = 10.0;
		public static var   m_positionIterations:int = 10.0;
		public static var m_timeStep:Number        = 1 / 30.0;		
		public static var scale:Number             = 30.0;
		
		//garbage list
		private static var garbage:Array;
		
		//parent sprite
		private static var parentSprite:Sprite;
		
		//debug settings
		private static var debugEnabled:Boolean = true;
		
		public function World(_parent:Sprite) 
		{
			garbage = new Array(); //array of garbage
			parentSprite = _parent;
			
			//create the world
			var worldAABB:b2AABB = new b2AABB();
			worldAABB.lowerBound.Set(-1000.0, -1000.0);
			worldAABB.upperBound.Set(1000.0, 1000.0);
			world = new b2World(new b2Vec2(0.0, 10.0), true);
			world.SetWarmStarting(true);
			
			// set debug draw
			debugDraw   = new b2DebugDraw();
			debugSprite = new Sprite();
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(scale);
			debugDraw.SetFillAlpha(0.3);
			debugDraw.SetLineThickness(1.0);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
			world.SetDebugDraw(debugDraw);
			parentSprite.addChild(debugSprite);
		}
		
		public static function SetDebugVisible(_is:Boolean):void
		{
			debugEnabled = _is;
		}
		
		public static function DestroyBody(_body:b2Body):void
		{
			garbage.push(_body);
		}
		
		public static function CreateBody(bodyDef:b2BodyDef):b2Body
		{
			return world.CreateBody(bodyDef);
		}
		
		public static function Update():void
		{
			//destroy the garbage
			while (garbage.length > 0)
			{
				world.DestroyBody(garbage[0]);				
				garbage.splice(0, 1);
			}
			
			if(debugEnabled)
			world.DrawDebugData();
			
			world.Step(m_timeStep, m_velocityIterations, m_positionIterations);
			world.ClearForces();			
		}		
	}
}