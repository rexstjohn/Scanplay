package com.physics.primitives  
{
	import Box2D.Collision.b2Bound;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Joints.b2JointDef;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import com.physics.World;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Ragdoll extends PhysicsObject
	{
		private var circleShape:b2CircleShape;
		
		//head
		public var head:b2Body;
		protected var torso:b2Body;
		protected var torso2:b2Body;
		protected var torso3:b2Body;
		
		//arms
		protected var upperArmL:b2Body;
		protected var upperArmR:b2Body;		
		protected var lowerArmL:b2Body;
		protected var lowerArmR:b2Body;
		
		//legs
		protected var upperLegL:b2Body;
		protected var upperLegR:b2Body;
		protected var lowerLegL:b2Body;
		protected var lowerLegR:b2Body;
		
		//joints
		protected var jointDef:b2RevoluteJointDef;
		
		//fixture details
		protected var density:Number = .1;
		
		public function Ragdoll(_x:Number, _y:Number) 
		{
			super();
			var startX:Number = _x;
			var startY:Number =_y ;
			bodyDef.type = b2Body.b2_dynamicBody;
			
			// CREATE THE HEAD
			circleShape = new b2CircleShape( 12.5 / World.scale );
			
			//fixture def
			fixtureDef.shape = circleShape;
			fixtureDef.density =  density;
			fixtureDef.friction = 0.4;
			fixtureDef.restitution = 0.3;
			
			//create the body def
			bodyDef.position.Set(startX / World.scale, startY / World.scale);
			
			//create the head
			head = World.CreateBody(bodyDef);
			head.CreateFixture(fixtureDef);
			
			//CREATE THE TORSO
			boxDef.SetAsBox(15 / World.scale, 10 / World.scale);
			
			//create the fixture
			fixtureDef.shape = boxDef;
			fixtureDef.density =  density;
			fixtureDef.friction = 0.4;
			fixtureDef.restitution = 0.1;
			
			//set position
			bodyDef.position.Set(startX / World.scale, (startY + 28) / World.scale);
			torso = World.CreateBody(bodyDef);
			torso.CreateFixture(fixtureDef);
			
			// THE SECOND TORSO SEGMENT
			boxDef = new b2PolygonShape();
			boxDef.SetAsBox(15 / World.scale, 10 / World.scale);
			
			//create the fixture
			fixtureDef.shape = boxDef;
			bodyDef.position.Set(startX / World.scale, (startY + 43) / World.scale);
			
			torso2 = World.CreateBody(bodyDef);
			torso2.CreateFixture(fixtureDef);
			
			//CREAT THE THIRD TORSO SEGMENT
			boxDef.SetAsBox(15 / World.scale, 10 / World.scale);
			fixtureDef.shape = boxDef;
			bodyDef.position.Set(startX / World.scale, (startY + 58) / World.scale);
			torso3 = World.CreateBody(bodyDef);
			torso3.CreateFixture(fixtureDef);
			
			// CREATE THE UPPER ARM
			fixtureDef.density =  density;
			fixtureDef.friction = 0.4;
			fixtureDef.restitution = 0.1;
			
			// L
			boxDef = new b2PolygonShape();
			boxDef.SetAsBox(18 / World.scale, 6.5 / World.scale);
			fixtureDef.shape =boxDef;
			bodyDef.position.Set((startX - 30) / World.scale, (startY + 20) / World.scale);
			upperArmL = World.CreateBody(bodyDef);
			upperArmL.CreateFixture(fixtureDef);
			
			// R
			boxDef = new b2PolygonShape();
			boxDef.SetAsBox(18 / World.scale, 6.5 / World.scale);
			fixtureDef.shape = boxDef;
			bodyDef.position.Set((startX + 30) / World.scale, (startY + 20) / World.scale);
			upperArmR = World.CreateBody(bodyDef);
			upperArmR.CreateFixture(fixtureDef);
			
			// LowerArm
			fixtureDef.density =  density;
			fixtureDef.friction = 0.4;
			fixtureDef.restitution = 0.1;
			
			// L
			boxDef = new b2PolygonShape();
			boxDef.SetAsBox(17 / World.scale, 6 / World.scale);
			fixtureDef.shape = boxDef;
			bodyDef.position.Set((startX - 57) / World.scale, (startY + 20) / World.scale);
			lowerArmL = World.CreateBody(bodyDef);
			lowerArmL.CreateFixture(fixtureDef);
			
			// R
			boxDef = new b2PolygonShape();
			boxDef.SetAsBox(17 / World.scale, 6 / World.scale);
			fixtureDef.shape = boxDef;
			bodyDef.position.Set((startX + 57) / World.scale, (startY + 20) / World.scale);
			lowerArmR = World.CreateBody(bodyDef);
			lowerArmR.CreateFixture(fixtureDef);
			
			// UpperLeg
			fixtureDef.density =  density;
			fixtureDef.friction = 0.4;
			fixtureDef.restitution = 0.1;
			
			// L
			boxDef = new b2PolygonShape();
			boxDef.SetAsBox(7.5 / World.scale, 22 / World.scale);
			fixtureDef.shape = boxDef;
			bodyDef.position.Set((startX - 8) / World.scale, (startY + 85) / World.scale);
			upperLegL = World.CreateBody(bodyDef);
			upperLegL.CreateFixture(fixtureDef);
			// R
			boxDef = new b2PolygonShape();
			boxDef.SetAsBox(7.5 / World.scale, 22 / World.scale);
			fixtureDef.shape =boxDef;
			bodyDef.position.Set((startX + 8) / World.scale, (startY + 85) / World.scale);
			upperLegR = World.CreateBody(bodyDef);
			upperLegR.CreateFixture(fixtureDef);
			
			// LowerLeg
			fixtureDef.density =  density;
			fixtureDef.friction = 0.4;
			fixtureDef.restitution = 0.1;
			
			// L
			boxDef = new b2PolygonShape();
			boxDef.SetAsBox(6 / World.scale, 20 / World.scale);
			fixtureDef.shape = boxDef;
			bodyDef.position.Set((startX - 8) / World.scale, (startY + 120) / World.scale);
			lowerLegL = World.CreateBody(bodyDef);
			lowerLegL.CreateFixture(fixtureDef);
			
			// R
			boxDef = new b2PolygonShape();
			boxDef.SetAsBox(6 / World.scale, 20 / World.scale);
			fixtureDef.shape = boxDef;
			bodyDef.position.Set((startX + 8) / World.scale, (startY + 120) / World.scale);
			lowerLegR = World.CreateBody(bodyDef);
			lowerLegR.CreateFixture(fixtureDef);				
			
			// JOINTS
			jointDef = new b2RevoluteJointDef();
			jointDef.enableLimit = true;
			
			// Head to shoulders
			jointDef.lowerAngle = -40 / (180/Math.PI);
			jointDef.upperAngle = 40 / (180/Math.PI);
			jointDef.Initialize(torso, head, new b2Vec2(startX / World.scale, (startY + 15) / World.scale));
			World.world.CreateJoint(jointDef);
			
			// Upper arm to shoulders
			// L
			jointDef.lowerAngle = -85 / (180/Math.PI);
			jointDef.upperAngle = 130 / (180/Math.PI);
			jointDef.Initialize(torso, upperArmL, new b2Vec2((startX - 18) / World.scale, (startY + 20) / World.scale));
			World.world.CreateJoint(jointDef);
			// R
			jointDef.lowerAngle = -130 / (180/Math.PI);
			jointDef.upperAngle = 85 / (180/Math.PI);
			jointDef.Initialize(torso, upperArmR, new b2Vec2((startX + 18) / World.scale, (startY + 20) / World.scale));
			World.world.CreateJoint(jointDef);
			
			// Lower arm to upper arm
			// L
			jointDef.lowerAngle = -130 / (180/Math.PI);
			jointDef.upperAngle = 10 / (180/Math.PI);
			jointDef.Initialize(upperArmL, lowerArmL, new b2Vec2((startX - 45) / World.scale, (startY + 20) / World.scale));
			World.world.CreateJoint(jointDef);
			// R
			jointDef.lowerAngle = -10 / (180/Math.PI);
			jointDef.upperAngle = 130 / (180/Math.PI);
			jointDef.Initialize(upperArmR, lowerArmR, new b2Vec2((startX + 45) / World.scale, (startY + 20) / World.scale));
			World.world.CreateJoint(jointDef);
			
			// Shoulders/stomach
			jointDef.lowerAngle = -15 / (180/Math.PI);
			jointDef.upperAngle = 15 / (180/Math.PI);
			jointDef.Initialize(torso, torso2, new b2Vec2(startX / World.scale, (startY + 35) / World.scale));
			World.world.CreateJoint(jointDef);
			
			// Stomach/hips
			jointDef.Initialize(torso2, torso3, new b2Vec2(startX / World.scale, (startY + 50) / World.scale));
			World.world.CreateJoint(jointDef);
			
			// Torso to upper leg
			// L
			jointDef.lowerAngle = -25 / (180/Math.PI);
			jointDef.upperAngle = 45 / (180/Math.PI);
			jointDef.Initialize(torso3, upperLegL, new b2Vec2((startX - 8) / World.scale, (startY + 72) / World.scale));
			World.world.CreateJoint(jointDef);
			// R
			jointDef.lowerAngle = -45 / (180/Math.PI);
			jointDef.upperAngle = 25 / (180/Math.PI);
			jointDef.Initialize(torso3, upperLegR, new b2Vec2((startX + 8) / World.scale, (startY + 72) / World.scale));
			World.world.CreateJoint(jointDef);
			
			// Upper leg to lower leg
			// L
			jointDef.lowerAngle = -25 / (180/Math.PI);
			jointDef.upperAngle = 115 / (180/Math.PI);
			jointDef.Initialize(upperLegL, lowerLegL, new b2Vec2((startX - 8) / World.scale, (startY + 105) / World.scale));
			World.world.CreateJoint(jointDef);
			// R
			jointDef.lowerAngle = -115 / (180/Math.PI);
			jointDef.upperAngle = 25 / (180/Math.PI);
			jointDef.Initialize(upperLegR, lowerLegR, new b2Vec2((startX + 8) / World.scale, (startY + 105) / World.scale));
			World.world.CreateJoint(jointDef);
		}
		
		public override function Update():void{}
		
		public override function Destroy():void
		{
			Main.physicsObjects.splice(Main.physicsObjects.indexOf(this), 1);
			
			World.DestroyBody(head);
			World.DestroyBody(torso);
			World.DestroyBody(torso2);
			World.DestroyBody(torso3);
			
			World.DestroyBody(upperArmL);
			World.DestroyBody(upperArmR);	
			World.DestroyBody(lowerArmL);
			World.DestroyBody(lowerArmR);
			
			 World.DestroyBody(upperLegL);
			 World.DestroyBody(upperLegR);
			 World.DestroyBody(lowerLegL);
			 World.DestroyBody(lowerLegR);
		}
	}

}