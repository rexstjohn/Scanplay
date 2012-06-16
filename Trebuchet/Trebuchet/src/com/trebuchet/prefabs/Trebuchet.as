package com.trebuchet.prefabs
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.b2Body;

	import com.core.interfaces.IPhysicsObject;
	import com.core.prefab.Prefab;
	import com.physics.PhysicsObject;

	import flash.geom.Point;

	public class Trebuchet extends Prefab
	{
		//physics objects representing the various trebuchet components
		private var _counterWeight:PhysicsObject;
		private var _throwingArm:PhysicsObject;
		public  var throwingArmAnchor:b2Body;
		private var _rope:Array;
		private var _payload:PhysicsObject; //aka ammunition
		public var latch:b2Body; //invisible latch used to hold the payload before firing

		//important joints we want to be able to access
		public var latchJoint:b2Joint; //joint binding the payload and the latch
		public var payloadJoint:b2Joint; //joint holding the payload to the throwing arm
		public var counterWeightJoint:b2Joint; //joint holding the payload to the throwing arm
		public var throwingArmJoint:b2Joint; //joint holding the payload to the throwing arm

		//utility methods
		public var destroyJoint:Function; // canned method for destroying all joints
		public var destroyBody:Function; // allow this trebuchet to destroy a body
		public var addPayload:Function; // allow this trebuchet to destroy a body
		public var resetLatch:Function; // allow this trebuchet to destroy a body
		public var reset:Function; // allow this trebuchet to destroy a body

		public function Trebuchet()
		{
			super();
		}

		//when the trebuchet arm is in motion, this causes the payload to release from the sling
		public function releasePayload():void
		{
			//launches the projectile
			destroyJoint(payloadJoint);
		}

		//when the trebuchet arm is idle, this causes the arm to be released by destroying the latch
		public function releaseLatch():void
		{
			//swizzled method for deleting all joints
			destroyJoint(latchJoint);

			//destroy the joint body as well
			destroyBody(latch);

			//apply an impulse downards to the counterbalance to make it fly
			_counterWeight.body.ApplyImpulse(new b2Vec2(0,50),_counterWeight.body.GetPosition()); 
		}

		public function loadTrebuchet():void
		{
			addPayload(this);
			resetLatch(_payload);
		}

		public function resetTrebuchet(_x:Number):Trebuchet
		{
			return reset(_x);
		}

		// ACCESSORS //

		//setters (setters because we need to manually add their skins to our parent skin on demand)
		public function set counterWeight(_obj:IPhysicsObject):void
		{
			_counterWeight = _obj as PhysicsObject;
			this.addChild(_counterWeight.skin);
		}

		public function set throwingArm(_obj:IPhysicsObject):void
		{
			_throwingArm = _obj as PhysicsObject;
			this.addChild(_throwingArm.skin);
		}

		public function set rope(_obj:Array):void
		{
			_rope=_obj;
			//TODO: add rope to skin
		} 

		public function set payload(_obj:IPhysicsObject):void
		{
			_payload = _obj  as PhysicsObject;;
			this.addChild(_payload.skin);
		}

		public function get rope():Array
		{return _rope;}

		public function get throwingArm():IPhysicsObject
		{return _throwingArm;}

		public function get payload():IPhysicsObject
		{return _payload;}
	}
}

