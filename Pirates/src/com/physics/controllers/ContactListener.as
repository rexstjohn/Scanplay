package com.physics.controllers
{
	import Box2D.Collision.b2Collision;
	import Box2D.Collision.b2Manifold;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Transform;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactImpulse;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.Contacts.b2Contact;
	import com.physics.blocks.PhysicsObject;
	import com.core.*;
	import Box2D.Common.Math.b2Math;
	import com.game.GameObject;
	import com.game.ship.weapon.Weapon;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 * 
	 * This is a modified contact listener that we mainly use to determine the strength of cannonball hits on
	 * other objects and then decide how much damage was done.
	 */
	public class ContactListener extends b2ContactListener
	{
		private var gameLevel:GameLevel;
		private var objectA:PhysicsObject;
		private var objectB:PhysicsObject;
		
		public function ContactListener(g:GameLevel) 
		{
			gameLevel = g;
		}
		
		private var i:int;
		
		override public function PostSolve(contact:b2Contact, impulse:b2ContactImpulse):void 
		{
			// Should the body break?
			var count:int = contact.GetManifold().m_pointCount;
			
			var collissionImpulse:Number = 0.0;
			for (i = 0; i < count; i++)
			{
				collissionImpulse = b2Math.Max(collissionImpulse, impulse.normalImpulses[i]);
			}
			
			//dispatch a message indicating the collission
			if (collissionImpulse > .1)
			{
				objectA = GameLevel.GetObjectByBody(contact.GetFixtureA().GetBody());
				objectB = GameLevel.GetObjectByBody(contact.GetFixtureB().GetBody());	
				
				if (objectA && objectB)
				{
					objectA.handleCollission(objectB, collissionImpulse);
					objectB.handleCollission(objectA, collissionImpulse);		
				}			
			}
			else
			{
				//if there is no other object, check and see
				//if we hit a static platform...
				if (objectA is Weapon)
				{
					Weapon(objectA).CheckStaticPlatformCollisions();
				}
			}
		}
	}
}