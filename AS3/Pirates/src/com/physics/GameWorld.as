package com.physics
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
	import com.physics.controllers.*;
	import Box2D.Dynamics.Controllers.*;
	import Box2D.Dynamics.Joints.*;
	import com.game.*;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class GameWorld
	{				
		//world stats
		public static var   m_velocityIterations:int = 10;
		public static var   m_positionIterations:int = 10;
		public static const m_timeStep:Number        = 1.0 / 30.0;		
		public static const pixels_per_meter:Number  = 30;
		public static const GridSize:Number          = 50;
		
		//the world
		static public var m_world:b2World;
		static public var debugSprite:Sprite;
		
		//custom controllers
		static public var gravityWellController:GravityWell;
		static public var stickyController:StickyController;
		
		public function GameWorld():void
		{			
			//create the world
			var worldAABB:b2AABB = new b2AABB();
			worldAABB.lowerBound.Set(-1000.0, -1000.0);
			worldAABB.upperBound.Set(1000.0, 1000.0);
			m_world = new b2World(new b2Vec2(0.0, 10.0), true);
			m_world.SetWarmStarting(true);
			
			// set debug draw
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			debugSprite = new Sprite();
			dbgDraw.SetSprite(debugSprite);
			dbgDraw.SetDrawScale(30.0);
			dbgDraw.SetFillAlpha(0.3);
			dbgDraw.SetLineThickness(1.0);
			dbgDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
			m_world.SetDebugDraw(dbgDraw);
			
			//debugSprite.visible = false;
			//Main.m_sprite.addChild(debugSprite);	
			
			gravityWellController = new GravityWell();
			stickyController       = new StickyController();
			
			m_world.AddController(gravityWellController);
			m_world.AddController(stickyController);
		}
		
		//destroy all the bodies in the level
		public static function destroyBodies():void
		{
			var b:b2Body = m_world.GetBodyList();
			var count:int = m_world.GetBodyCount();
			
			while (count > 0)
			{
			    var nextB:b2Body = b;			  
			    b = b.GetNext();
			    m_world.DestroyBody(nextB);
			    nextB = null;
				count--;
			}		
		}

		/*
		 * UPDATE
		 * 
		 */	
		
		public static function update(e:Event):void
		{
			// Update physics
			//var physStart:uint = getTimer();
			m_world.Step(m_timeStep, m_velocityIterations, m_positionIterations);
			m_world.ClearForces();			
			
		}
		
		public static function start():void
		{
			Main.m_stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		public static function Pause():void
		{
			Main.m_stage.removeEventListener(Event.ENTER_FRAME, update);			
		}
		
		//stop the world and clear everything.
		public static function destroy():void
		{
			Main.m_stage.removeEventListener(Event.ENTER_FRAME, update);

			destroyBodies();			
			m_world = null;
		}		
	}
}