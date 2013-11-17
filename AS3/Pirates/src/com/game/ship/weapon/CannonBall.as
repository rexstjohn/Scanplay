package com.game.ship.weapon 
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import com.game.*;
	import com.physics.GameWorld;
	import flash.display.Sprite;
	import com.core.factory.AssetFactory;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import com.physics.factory.PhysicsFactory
	import flash.ui.ContextMenuBuiltInItems;
	import com.core.*;
	
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
	public class CannonBall extends Weapon
	{		
		public function CannonBall(_p:Point,angle:Number, force:Number, _paints:Boolean = true) 
		{				
			super(_p,8, force, angle, "Cannonball", 10, _paints);				
		}		
	}
}