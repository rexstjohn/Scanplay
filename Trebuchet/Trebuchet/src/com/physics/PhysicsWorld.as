package com.physics
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2JointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	
	import com.core.interfaces.*;
	import com.core.util.GraphicsUtils;
	import com.core.util.SuperSprite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;

	public class PhysicsWorld
	{
		//AABB bounds
		private static const LOWER_BOUND:Point = new Point(-1000.0,-1000.0);
		private static const UPPER_BOUND:Point = new Point(-1000.0,-1000.0);

		//Gravity
		private static const GRAVITY:b2Vec2 = new b2Vec2(0.0,10.0);

		//Draw scale
		public static const SCALE:Number = 30.0;
		private static const TIME_STEP:Number = 1.0/30.0;
		private static const VELOCITY_ITERATIONS:int = 10;
		private static const POSITION_ITERATIONS:int = 10;
		private static const GRID_SIZE:int = 50;

		//wall thickness
		public static const WALL_THICKNESS:Number = 25;

		//instance vars
		private var _world:b2World;
		private var _doDebugDraw:Boolean = false;
		private var _drawGrid:Boolean = false;
		private var _physicsObjects:Array;
		private var _canvas:SuperSprite; //copy of the canvas

		public function PhysicsWorld(_bounds:Rectangle, _canvas:SuperSprite)
		{
			this._canvas = _canvas;
			_physicsObjects = new Array();

			//define the bounding box
			var worldAABB:b2AABB = new b2AABB();
			worldAABB.lowerBound.Set(LOWER_BOUND.x, LOWER_BOUND.y);
			worldAABB.upperBound.Set(UPPER_BOUND.x,UPPER_BOUND.y);

			// Define the gravity vector
			var gravity:b2Vec2 = GRAVITY;

			// Allow bodies to sleep
			var doSleep:Boolean = true;

			// Construct a world object
			_world = new b2World(gravity, doSleep)
			_world.SetWarmStarting(true);

			//enable debug draw behavior
			var _debugDraw:b2DebugDraw = new b2DebugDraw();
			_debugDraw.SetSprite(_canvas);
			_debugDraw.SetDrawScale(SCALE);
			_debugDraw.SetFillAlpha(0.3);
			_debugDraw.SetLineThickness(1.0);
			_debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
			_world.SetDebugDraw(_debugDraw);
		}

		public function get world():b2World
		{
			return _world;
		}

		public function enableDebugDraw(_enabled:Boolean = false):void
		{
			_doDebugDraw = _enabled;
		}
		
		public function enableGrid(_enabled:Boolean = false):void
		{
			_drawGrid = _enabled;
		}

		private function createWall(_x:Number, _y:Number, _width:Number, _height:Number):void
		{
			// Create border of boxes
			var wall:b2PolygonShape= new b2PolygonShape();
			var wallBd:b2BodyDef = new b2BodyDef();
			var wallB:b2Body;

			wallBd.position.Set( toWorld(_x), toWorld(_y));
			wall.SetAsBox(toWorld(_width)/2, toWorld(_height)/2);
			wallB = _world.CreateBody(wallBd);
			wallB.CreateFixture2(wall);
		}

		public function createBody(_def:b2BodyDef):b2Body
		{
			return _world.CreateBody(_def);
		}

		public function createJoint(_def:b2JointDef):b2Joint
		{
			return _world.CreateJoint(_def);
		}

		public function getGroundBody():b2Body
		{
			return _world.GetGroundBody();
		}

		//just so we dont have to recreate this every frame
		private var _physStart:uint;

		public function updatePhysics(e:Event):void 
		{
			// Update physics
			_physStart = getTimer();
			_world.Step(TIME_STEP, VELOCITY_ITERATIONS, POSITION_ITERATIONS);
			_world.ClearForces();

			// draw debugging information
			if(_doDebugDraw)
				_world.DrawDebugData();
				
			//draw a grid?
			if(_drawGrid)
				GraphicsUtils.drawGrid(_canvas,GRID_SIZE,GRID_SIZE);

			//update all the physics objects
			for each(var o:IPhysicsObject in _physicsObjects)
			{
				o.updatePhysics(e);
			}
		}

		//insert a physics object
		public function addPhysicsObject(_phys:IPhysicsObject):void
		{
			_physicsObjects.push(_phys);
		}

		//remove a physics object from the world
		public function removePhysicsObject(_phys:IPhysicsObject):void
		{
			if(_physicsObjects.indexOf(_phys))
			{
				var index:int = _physicsObjects.indexOf(_phys);
				_physicsObjects.splice(index,1);
			}
			destroyBody(_phys.body);
		}

		//destroy a joint
		public function destroyJoint(_joint:b2Joint):void
		{
			_world.DestroyJoint(_joint);
		}

		//destroy a body
		public function destroyBody(_body:b2Body):void
		{
			_world.DestroyBody(_body);
		}

		//utility functions
		public static function toWorldPoint(_point:Point):Point
		{
			return new Point(_point.x / SCALE, _point.y / SCALE);
		}

		public static function toWorld(_val:Number):Number
		{
			return _val / SCALE;
		}

		public static function toWorldVec2(_point:Point):b2Vec2
		{
			return new b2Vec2(_point.x / SCALE, _point.y / SCALE);
		}

		public static function toWorldVec3(_vec:b2Vec2):b2Vec2
		{
			return new b2Vec2(_vec.x / SCALE, _vec.y / SCALE);
		}

		public static function toCanvas(_val:Number):Number
		{
			return _val * SCALE;
		}
	}
}

