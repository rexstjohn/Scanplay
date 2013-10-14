package com.game.ship.weapon 
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import com.game.*;
	import com.physics.blocks.PhysicsObject;
	import com.physics.GameWorld;
	import com.core.factory.AssetFactory;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.ContextMenuBuiltInItems;
	import com.core.*;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 * 
	 * Some notes on the cannonball...this is a very important class.
	 * 
	 * When a cannon ball comes to rest or is terminated, it resets the camera to the
	 * default target(usually the ship, almost always) and tells the ship to reset it's cannon to
	 * the default mode. 
	 */
	public class Shrapnel extends Weapon
	{		
		public function Shrapnel(_p:Point,angle:Number, force:Number) 
		{				
			super(_p, 5, force, angle, "Cannonball", 4);
		}
		
		protected override function Update(e:Event):void
		{
			if (body)
			{
				skin.x = ( body.GetPosition().x * GameWorld.pixels_per_meter);
				skin.y = ( body.GetPosition().y * GameWorld.pixels_per_meter );
				skin.rotation =  body.GetAngle() * ( 180 / Math.PI);
			}
		}		
	}

}