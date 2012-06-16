package com.physics
{
	import Box2D.Dynamics.Joints.b2JointEdge;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;

	public class PhysicsUtils
	{
		private var _world:PhysicsWorld;

		public function PhysicsUtils(_world:PhysicsWorld):void
		{
			this._world = _world;
		}

		public function clearJoints(_body:b2Body):void
		{
			//got a doubly linked list traversal here
			for(var nextJoint:b2JointEdge = _body.GetJointList();nextJoint.next != null;nextJoint.next )
			{
				_world.destroyJoint(nextJoint.joint);
			}
		}

		public function jointsToArray(_body:b2Body):Array
		{
			var _joints:Array = new Array();
			var nextJoint:b2JointEdge = _body.GetJointList();

			while(nextJoint = _body.GetJointList().next)
			{
				_joints.push(nextJoint.joint);
			}

			return _joints;
		}
	}
}

