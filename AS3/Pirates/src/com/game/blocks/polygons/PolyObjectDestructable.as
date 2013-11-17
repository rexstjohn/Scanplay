package com.game.blocks.polygons
{
	import Box2D.Dynamics.*;
	import com.physics.*;
	import com.physics.blocks.*;
	import com.game.*;
	import com.game.ship.weapon.*;
	import flash.events.*;
	import flash.utils.*;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * A Polygon object that can be destroyed.
	 */
	public class PolyObjectDestructable extends Polygon2D
	{		
		public function PolyObjectDestructable(_p:Array, t:String) 
		{
			super(_p, t);
			damagedState = t;
		}		

		public override function handleCollission(o:PhysicsObject, force:Number):void
		{
			if(health > 0)
			{
				if (health > 0)
				{
					if (o is Weapon)
					{
						health -= (Weapon(o).GetDamage()  * force); 
					}
					else
					{
						health -= (force);
					}
				}
			}
			
			//this is a gigantic hack
			//to avoid problems with bullets hitting polygon shapes.
			if (o is Weapon || (o is PolyObjectDestructable))
			{
				o.GetBody().SetBullet(false);
			}
		}
		
			
		/*
		 * Destroy the projectile next timestep that is available
		 * 
		 */
		public function destroy():void
		{
			var t:Timer = new Timer(5);
			 t.addEventListener(TimerEvent.TIMER, waitForUnlock);
			 t.start();
			 
			 function waitForUnlock(e:TimerEvent):void
			 {				 
				 if(!GameWorld.m_world.IsLocked())
				 {
					 t.stop();
					 t.removeEventListener(TimerEvent.TIMER, waitForUnlock);
					//var booms:Array = new Array();
					GameWorld.m_world.DestroyBody(body);
					
					if (Main.m_sprite.contains(skin))
					{
						Main.m_sprite.removeChild(skin);
						Main.m_sprite.removeChild(texture);
					}
				 }
			 }
		}
	}
}