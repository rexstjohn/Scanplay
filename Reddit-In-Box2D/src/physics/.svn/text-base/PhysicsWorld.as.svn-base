package physics
{
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Dynamics.Controllers.*;
	import Box2D.Dynamics.Joints.*;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class PhysicsWorld
	{				
		//world stats
		public static var   m_velocityIterations:int = 10;
		public static var   m_positionIterations:int = 10;
		public static const m_timeStep:Number        = 1.0 / 30.0;		
		public static const pixels_per_meter:Number  = 30;
		public static const GridSize:Number          = 25;
		
		//the world
		public static var world:b2World;
		public static var debugSprite:Sprite;
		
		//garbage list
		public static var garbageList:Array;
		
		//the ground body
		public static var groundBody:GroundBody;
		
		//the update list
		public static var updateList:Array;
		
		public function PhysicsWorld():void
		{			
			//create the world
			var worldAABB:b2AABB = new b2AABB();
			worldAABB.lowerBound.Set(-1000.0, -1000.0);
			worldAABB.upperBound.Set(1000.0, 1000.0);
			world = new b2World(new b2Vec2(0.0, 10.0), true);
			world.SetWarmStarting(true);
			
			// set debug draw
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			debugSprite = new Sprite();
			Main.AddChild(debugSprite);	
			dbgDraw.SetSprite(debugSprite);
			dbgDraw.SetDrawScale(GetScale());
			dbgDraw.SetFillAlpha(.6);
			dbgDraw.SetLineThickness(1.0);
			dbgDraw.SetFlags(b2DebugDraw.e_shapeBit);
			world.SetDebugDraw(dbgDraw);
			
			//create the garbage
			garbageList = new Array();
			
			//list of game objects that need to be updated
			updateList  = new Array();
			
			//create a ground body for basic testing
			groundBody = new GroundBody(0, 1860);
			Main.AddChild(groundBody);
		}
		
		//returns the pixels per meter
		public static function GetScale():Number
		{
			return pixels_per_meter;
		}

		public static function DestroyObject(o:PhysicsObject):void
		{
			garbageList.push(o);
		}
		
		public static function Subscribe(o:GameSprite):void
		{
			updateList.push(o);
		}
		
		public static function Unsubscribe(o:GameSprite):void
		{
			for each(var d:GameSprite in updateList)
			{
				if (o == d)
				updateList.splice(updateList.indexOf(o), 1);
			}
		}
		
		public static function GetWorld():b2World
		{
			return world;
		}
		
		/*
		 * UPDATE
		 * 
		 */	
		
		public static function CreateBody(bodydef:b2BodyDef):b2Body
		{
			return (world.CreateBody(bodydef));
		}
		
		public static function Update():void
		{
			//clean any garbage
			while(garbageList.length > 0)
			{
				world.DestroyBody(garbageList[0].GetBody());
				garbageList.splice(0, 1);
			}
			
			//run the update list
			for each(var o:GameSprite in updateList)
			{
				o.Update();
			}
			
			world.Step(m_timeStep, m_velocityIterations, m_positionIterations);
			world.ClearForces();	
		//	world.DrawDebugData();
			
			//update the ground body
			groundBody.Update();
		}
			
	}
}