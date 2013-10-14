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
	 * This is mainly for the sticky block.
	 * 
	 * Anything that touches the sticky block, acts as though it is strongly gravitationally attracted to the block
	 */
	public class StickyController extends b2Controller
	{		
		public var G:Number = 1;
		public var stickyBlocks:Array;
		public var stuckBlocks:Array;
		
		//some useful vars 
		private var f:b2Vec2 = new b2Vec2(0, 0);
		private var p1:b2Vec2 = new b2Vec2(0, 0);
		private var p2:b2Vec2 = new b2Vec2(0, 0);
		private var g:PhysicsObject;
		private var k:PhysicsObject;
		/**
		 * If true, gravity is proportional to r^-2, otherwise r^-1
		 */
		public var invSqr:Boolean = true;
		
		public function StickyController()
		{
			stickyBlocks = new Array();
			stuckBlocks = new Array();
		}
		
		public function AddStickyBlock(b:PhysicsObject):void
		{
			stickyBlocks.push(b);
		}	
		
		public function AddStuckBlock(b:PhysicsObject):void
		{
			stuckBlocks.push(b);
		}
		
		public function HasBlock(b:PhysicsObject):Boolean
		{
			var has:Boolean = false;
			for each(g in stuckBlocks)
			{
				if (g == b)
				{
					has = true;
				}
			}
			
			return has;
		}
	
		//every time step, make all the objects in the body list attract towards the magnet brick
		public override function Step(step:b2TimeStep):void
		{
			//Inlined
			var currentMagnetBlock:b2Body = null;
			var gravityTarget:b2Body      = null;
			var mass1:Number = 0;
			
			//MATH STUFF
			var dx:Number = 0;
			var dy:Number = 0;
			var r2:Number = 0;
			
			//start with the gravity blocks
			for each(g in stickyBlocks)
			{
				//get the body of the blocks
				currentMagnetBlock  = g.GetBody();
				p1                  = currentMagnetBlock.GetPosition();
				mass1               = currentMagnetBlock.GetMass();
				
				//next, get all the world bodies
				for each(k in stuckBlocks)
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
						f.x  = dx;
						f.y  = dy;
						f.Multiply(G / r2 / Math.sqrt(r2) * 850 * gravityTarget.GetMass());					
						f.Multiply( -1);
						
						//gravitate the body
						if (gravityTarget.IsAwake())
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