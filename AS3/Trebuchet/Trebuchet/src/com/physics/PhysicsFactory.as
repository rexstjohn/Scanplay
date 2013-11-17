package com.physics
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;

	import com.core.interfaces.IPhysicsObject;
	import com.trebuchet.assets.Library;

	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class PhysicsFactory
	{
		private var _world:PhysicsWorld;

		public function PhysicsFactory(_world:PhysicsWorld):void
		{
			this._world = _world;
		}

		//creates a boundary around the world
		public function createWorldContainer(_bounds:Rectangle):void
		{
			var left:Rectangle = new Rectangle(_bounds.x, _bounds.y + (_bounds.height / 2),PhysicsWorld.WALL_THICKNESS,_bounds.height);//left
			var right:Rectangle = new Rectangle(_bounds.x + _bounds.width,_bounds.y + (_bounds.height / 2),PhysicsWorld.WALL_THICKNESS,_bounds.height);//right
			var top:Rectangle = new Rectangle(_bounds.x + (_bounds.width / 2),_bounds.y , _bounds.width,PhysicsWorld.WALL_THICKNESS); //top
			var bottom:Rectangle = new Rectangle(_bounds.x + (_bounds.width / 2),_bounds.y + _bounds.height,_bounds.width,PhysicsWorld.WALL_THICKNESS); //bottom

			//create some default walls
			createSquareBody(left,false);
			createSquareBody(right,false);
			createSquareBody(top,false);
			createSquareBody(bottom,false);
		}

		//create a physics objects given an attributes object
		public function createPhysicsObjectFromAttributes(_attributes:PhysicsAttributes):PhysicsObject
		{
			// Create border of boxes
			var _bounds:Rectangle = _attributes.bounds;
			var blockShape:b2PolygonShape= new b2PolygonShape();
			var blockDef:b2BodyDef = new b2BodyDef();
			var blockBody:b2Body;

			//make the body definition dynamic so it will move around
			blockDef.position.Set( PhysicsWorld.toWorld(_bounds.x), PhysicsWorld.toWorld(_bounds.y));

			if(_attributes.isDynamic)
				blockDef.type = b2Body.b2_dynamicBody;

			//init basics in regards to shape
			switch(_attributes.shape)
			{
				case PhysicsAttributes.POLYGON_SHAPE:
				case PhysicsAttributes.CIRCLE_SHAPE:
				case PhysicsAttributes.SQUARE_SHAPE:
				default :
					blockShape.SetAsBox(PhysicsWorld.toWorld(_bounds.width)/2, PhysicsWorld.toWorld(_bounds.height)/2);
					break;

			}
			blockBody = _world.createBody(blockDef);

			//create a fixture on our body
			var fixtureDef:b2FixtureDef  = new b2FixtureDef();
			fixtureDef.shape       = blockShape;
			fixtureDef.density     = _attributes.density;
			fixtureDef.friction    = _attributes.friction;
			fixtureDef.restitution = _attributes.restitution;	
			blockBody.CreateFixture(fixtureDef);

			//create the skin asset
			var skin:Sprite = Library.createAsset(_attributes.skinName);
			skin.width = _bounds.width;
			skin.height = _bounds.height;

			// Create the physics object and return it
			var physicsObject:PhysicsObject = new PhysicsObject();
			physicsObject.initialize(blockBody,skin);

			return physicsObject;
		}

		//creates a non-skinned physics object
		public function createSquareBody(_bounds:Rectangle, _dynamic:Boolean = true):b2Body
		{
			// Create border of boxes
			var blockShape:b2PolygonShape= new b2PolygonShape();
			var blockDef:b2BodyDef = new b2BodyDef();
			var blockBody:b2Body;

			//make the body definition dynamic so it will move around
			blockDef.position.Set( PhysicsWorld.toWorld(_bounds.x), PhysicsWorld.toWorld(_bounds.y));
			if(_dynamic)blockDef.type = b2Body.b2_dynamicBody;

			//init basics
			blockShape.SetAsBox(PhysicsWorld.toWorld(_bounds.width)/2, PhysicsWorld.toWorld(_bounds.height)/2);
			blockBody = _world.createBody(blockDef);
			//blockBody.CreateFixture2(blockShape);

			//create a fixture on our body
			var fixtureDef:b2FixtureDef  = new b2FixtureDef();
			fixtureDef.shape       = blockShape;
			fixtureDef.density     = .05;
			fixtureDef.friction    = 0.3;
			fixtureDef.restitution = 0.4;	
			blockBody.CreateFixture(fixtureDef);

			return blockBody;
		}

		//general purpose constructor methods
		public function createBlock2D(_bounds:Rectangle,_skinAssetKey:String, _dynamic:Boolean = true):PhysicsObject
		{
			var body:b2Body = createSquareBody(_bounds,_dynamic);

			//create the skin asset
			var skin:Sprite = Library.createAsset(_skinAssetKey);
			skin.width = _bounds.width;
			skin.height = _bounds.height;

			// Create the physics object and return it
			var physicsObject:PhysicsObject = new PhysicsObject();
			physicsObject.initialize(body,skin);

			return physicsObject;
		}

		//use this to create an anchor pin on a physics body
		public function createAnchor(_x:Number, _y:Number, _bodyA:b2Body, _bodyB:b2Body):b2Joint
		{
			//define the joint
			var jointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
			//jointDef.lowerAngle = -15 / (180/Math.PI);
			//jointDef.upperAngle = 15 / (180/Math.PI);
			jointDef.enableLimit = false;

			//create an ancor point using the joint
			var anchor:b2Vec2 = new b2Vec2();
			anchor.Set(PhysicsWorld.toWorld(_x),PhysicsWorld.toWorld(_y));
			jointDef.Initialize(_bodyA, _bodyB, anchor);

			return _world.createJoint(jointDef);
		}

		//use this to create a joint on a physics object
		public function createAnchor2(_x:Number, _y:Number, _bodyA:IPhysicsObject, _bodyB:IPhysicsObject):b2Joint
		{
			//define the joint
			var jointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
			//jointDef.lowerAngle = -15 / (180/Math.PI);
			//jointDef.upperAngle = 15 / (180/Math.PI);
			jointDef.enableLimit = false;

			//create an ancor point using the joint
			var anchor:b2Vec2 = new b2Vec2();
			anchor.Set(PhysicsWorld.toWorld(_x),PhysicsWorld.toWorld(_y));
			jointDef.Initialize(_bodyA.body, _bodyB.body, anchor);

			return _world.createJoint(jointDef);
		}

		//creates a box2d rope
		public function createRope(_anchorX:Number, _anchorY:Number,_length:Number, _linkCount:Number = 10):Array
		{
			var segments:Array;

			//rope stuff
			var boxDef:b2PolygonShape;
			var bodyDef:b2BodyDef;
			var revoluteJointDef:b2RevoluteJointDef;
			var fixtureDef:b2FixtureDef;
			var lastLink:b2Body;
			var chainLink:b2Body;

			//chain details
			var chainBlockWidth:Number = 2;
			var chainBlockHeight:Number = _length/_linkCount;

			//anchor point
			var anchorPoint:Point;

			segments      = new Array();
			boxDef        = new b2PolygonShape();
			bodyDef       = new b2BodyDef();
			fixtureDef    = new b2FixtureDef();
			anchorPoint   = new Point(_anchorX, _anchorY);

			// rope
			for (var i:int = 0; i < _linkCount; i++)
			{
				boxDef.SetAsBox((chainBlockWidth / 2) / PhysicsWorld.SCALE, (chainBlockHeight / 2) / PhysicsWorld.SCALE);
				bodyDef.type = b2Body.b2_dynamicBody;

				fixtureDef.shape       = boxDef;
				fixtureDef.density     = 5;
				fixtureDef.friction    = 0;
				fixtureDef.restitution = 0;			

				//create the body
				chainLink = _world.createBody(bodyDef);
				chainLink.CreateFixture(fixtureDef);
				chainLink.SetPosition(new b2Vec2(_anchorX / PhysicsWorld.SCALE, (_anchorY + (chainBlockHeight * i)) / PhysicsWorld.SCALE));

				segments.push(chainLink);

				var worldPoint:b2Vec2; 

				if (i > 0)
				{
					// joint
					worldPoint= new b2Vec2(PhysicsWorld.toWorld(_anchorX), (i * PhysicsWorld.toWorld(chainBlockHeight)) + PhysicsWorld.toWorld(_anchorY));
					lastLink = segments[i-1];
					revoluteJointDef = new b2RevoluteJointDef();
					revoluteJointDef.enableLimit = true;
					revoluteJointDef.Initialize(lastLink, chainLink, worldPoint);
					_world.createJoint(revoluteJointDef);
				}
			}

			lastLink = segments[0];

			//			use this to attach the rope to a static world point
			//			var ropeAnchorPointBounds:Rectangle = new Rectangle(anchorPoint.x, anchorPoint.y,5,5);
			//			var stat:b2Body = createSquareBody(ropeAnchorPointBounds,false);
			//			revoluteJointDef = new b2RevoluteJointDef();
			//			revoluteJointDef.Initialize(lastLink, stat, new b2Vec2(PhysicsWorld.toWorld(_anchorX), PhysicsWorld.toWorld(_anchorY)));
			//			_world.createJoint(revoluteJointDef);

			return segments;
		}
	}
}

