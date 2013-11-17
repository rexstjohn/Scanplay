package com.game.ship.weapon 
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import com.physics.blocks.PhysicsObject;
	import com.game.*;
	import com.physics.GameWorld;
	import flash.display.Sprite;
	import com.core.factory.AssetFactory;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.ContextMenuBuiltInItems;
	import com.core.*;
	import flash.utils.Timer;
	import com.core.factory.SoundFactory;
	
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
	public class RubberShot extends Weapon
	{		
		private var rest:Number = 1.4;
		
		public function RubberShot(_p:Point,angle:Number, force:Number) 
		{				
			super(_p, 12, force, angle, "RubberCannonball", 10);
			body.GetFixtureList().SetRestitution(1.4);
		}		
		
		public override function handleCollission(o:PhysicsObject, f:Number):void
		{
			state = "damaged";
			painter.Destroy();
			
			SoundFactory.PlaySound("WoodHit2", false,false, .3);
			rest -= .1;			
			body.GetFixtureList().SetRestitution(rest);			
		}
	}
}