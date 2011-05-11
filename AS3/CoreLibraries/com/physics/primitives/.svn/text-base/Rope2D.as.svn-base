package com.physics.primitives 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.Joints.b2JointDef;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import flash.display.InterpolationMethod;
	import flash.geom.Point;
	import physics.World;
/**
* ...
* @author ScanPlayGames
*/
public class Rope2D extends PhysicsObject
{
	protected var segments:Array;

	//rope stuff
	private var revoluteJointDef:b2RevoluteJointDef;
	private var lastLink:b2Body;
	private var chainLink:b2Body;

	//chain details
	private var chainBlockWidth:Number = 10;
	private var chainBlockHeight:Number = 20;

	//anchor point
	private var anchorPoint:Point;

	public function Rope2D(_anchorX:Number, _anchorY:Number, _linkCount:Number = 10)
	{
		super();

		segments    = new Array();
		anchorPoint = new Point(_anchorX, _anchorY);

		var stat:StaticBlock2D = new StaticBlock2D(anchorPoint.x, anchorPoint.y,5,5);

		// rope
		for (var i:int = 0; i < _linkCount; i++)
		{
			boxDef.SetAsBox((chainBlockWidth / 2) /World.scale, (chainBlockHeight / 2) /World.scale);
			bodyDef.type = b2Body.b2_dynamicBody;

			fixtureDef.shape = boxDef;
			fixtureDef.density = .05;
			fixtureDef.friction = 0.3;
			fixtureDef.restitution = 0.4;

			//create the body
			chainLink = World.CreateBody(bodyDef);
			chainLink.CreateFixture(fixtureDef);
			chainLink.SetPosition(new b2Vec2(_anchorX / World.scale, (_anchorY + (chainBlockHeight * i)) / World.scale));

			segments.push(chainLink);

			if (i > 0)
			{
				// joint
				lastLink = segments[i-1];
				revoluteJointDef = new b2RevoluteJointDef();
				revoluteJointDef.Initialize(lastLink, chainLink, new b2Vec2(_anchorX/ World.scale, (i * (chainBlockHeight / World.scale)) + (_anchorY / World.scale)));
				World.world.CreateJoint(revoluteJointDef);
				// saving the reference of the last placed link
				//lastLink.ApplyImpulse(new b2Vec2(1, 1), new b2Vec2(0,0));
			}
		}

			lastLink = segments[0];
			revoluteJointDef = new b2RevoluteJointDef();
			revoluteJointDef.Initialize(lastLink, stat.GetBody(), new b2Vec2(_anchorX/ World.scale, (_anchorY / World.scale)));
			World.world.CreateJoint(revoluteJointDef);
		}
		
		//attach a body to the rop
		public function AttachBody(_body:b2Body):void
		{			
			lastLink = segments[segments.length - 1];
			_body.SetPosition(lastLink.GetPosition());
			revoluteJointDef = new b2RevoluteJointDef();
			revoluteJointDef.Initialize(lastLink, _body, lastLink.GetPosition());
			World.world.CreateJoint(revoluteJointDef);
		}
	}
}