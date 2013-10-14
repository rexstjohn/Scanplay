package com.physics.controllers 
{
	import Box2D.Dynamics.Controllers.b2Controller;
	import Box2D.Common.Math.*;
	import Box2D.Common.*;
	import Box2D.Collision.Shapes.*;
	import com.physics.blocks.PhysicsObject;
	import com.game.GameObject
	import com.game.GameObject;
	import com.game.ship.weapon.Weapon;
	import com.physics.GameWorld;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.Controllers.b2ControllerEdge;
	import Box2D.Dynamics.Controllers.b2GravityController;
	import com.game.blocks.crates.*;
	import com.core.GameLevel;

	
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * This is mainly for the gravity / magent brick.
	 */
	public class GravityWell extends b2Controller
	{		
		public var G:Number = 1;
		public var gravityBlocks:Array;
		
		//some vectors we dont want to keep creating
		private var f:b2Vec2 = new b2Vec2(0,0);
		private var p2:b2Vec2 = new b2Vec2(0,0);
		private var p1:b2Vec2 = new b2Vec2(0, 0);
		private var g:PhysicsObject;
		private var k:PhysicsObject;
		/**
		 * If true, gravity is proportional to r^-2, otherwise r^-1
		 */
		public var invSqr:Boolean = true;
		
		public function GravityWell()
		{
			gravityBlocks = new Array();
		}
		
		public function AddGravityBlock(b:PhysicsObject):void
		{
			gravityBlocks.push(b);
		}		
	
		//every time step, make all the objects in the body list attract towards the magnet brick
		public override function Step(step:b2TimeStep):void
		{
			//Inlined
			var currentMagnetBlock:b2Body = null;
			var gravityTarget:b2Body      = null;
			var mass1:Number = 0;
			
			//the gravitor is what is getting pulled
			var gravitor:b2Body = GameWorld.m_world.GetBodyList();
			var objects:Array = GameLevel.GetObjects();
			
			//MATH STUFF
			var dx:Number = 0;
			var dy:Number = 0;
			var r2:Number = 0;
			
			//start with the gravity blocks
			for each(g in gravityBlocks)
			{
				//get the body of the blocks
				currentMagnetBlock  = g.GetBody();
				p1                  = currentMagnetBlock.GetPosition();
				mass1               = currentMagnetBlock.GetMass();
				
				//next, get all the world bodies
				for each(k in objects)
				{
					//this gravity well only affects cannonballs, nothing else
					if (k is Weapon)
					{
						//the thing being affected by gravity
						gravityTarget = k.GetBody();
						p2            = gravityTarget.GetPosition()
						dx            = p2.x - p1.x;
						dy            = p2.y - p1.y;
						r2            = dx * dx + dy * dy;
						
						if(r2<Number.MIN_VALUE)
							continue;
						f.x = dx;
						f.y = dy;
						f.Multiply(G / r2 / Math.sqrt(r2) * 450 * gravityTarget.GetMass());					
						f.Multiply( -1);
						
						//gravitate the body
						if (gravityTarget.IsActive())
						gravityTarget.ApplyForce(f, p2);
						
						//sleep the target if it gets too close
						if (Math.sqrt(r2) <= (46 / GameWorld.pixels_per_meter))
						gravityTarget.SetActive(false);
					}					
				}		
			}
		}
	}
}