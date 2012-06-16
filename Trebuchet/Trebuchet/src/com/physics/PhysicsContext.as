package com.physics
{
	import com.core.interfaces.IEvent;
	import com.core.interfaces.IObserver;
	import com.core.interfaces.IPhysicsObject;
	import com.core.mvc.EventBus;
	import com.physics.events.PhysicsStartedEvent;
	import com.physics.events.PhysicsStoppedEvent;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;

	//Manages all the crap having to do with a physics environment
	//the physics context is a class cluster that behaves as a single class
	//so the underlying components are exposed via the cluster but we don't have to think about them individually
	//generally speaking the goal is to package all physics functions into a single maanged interface
	public class PhysicsContext implements IObserver
	{
		//physics states
		public static const RUNNING:String="running";
		public static const PAUSED:String="paused";

		//debug states
		public static const DEBUG_ON:String="debug on";
		public static const DEBUG_OFF:String="debug off";

		//border definition of the physics world
		private static const WORLD_BOUNDS:Rectangle = new Rectangle(0,0,800,600);

		//utility methods
		private var _physicsUtils:PhysicsUtils;

		//a general purpose context in which physics can occur.
		private var _world:PhysicsWorld; //physics world
		private var _factory:PhysicsFactory; //factory for generating physics objects
		private var _canvas:Sprite; //canvas where all the physics occurs

		//state of the physics context
		private var _runningState:String = PAUSED;
		private var _debugState:String = DEBUG_OFF;

		public function PhysicsContext(_canvas:Sprite, _bounds:Rectangle = null)
		{
			//create the world
			this._world = new PhysicsWorld((_bounds == null)?WORLD_BOUNDS:_bounds,_canvas);

			//create the physics factory
			this._factory = new PhysicsFactory(_world);

			//create default walls on the world
			this._factory.createWorldContainer((_bounds == null)?WORLD_BOUNDS:_bounds);

			//initialize the sprite (generally pass in  view that you want to have physics occur inside of)
			this._canvas = _canvas;

			//set up our utilities
			this._physicsUtils = new PhysicsUtils(this._world);

			//start the updates
			this._canvas.addEventListener(Event.ENTER_FRAME, updatePhysics);
		}

		//IObserver
		public function update(e:IEvent):void
		{}

		public function notify(e:IEvent):void
		{
			EventBus.instance.notify(e);
		}

		public function unsubscribe():void
		{
			EventBus.instance.unsubscribe(this);
		}

		//set states
		public function start():void
		{
			_runningState = RUNNING;
			this.notify(new PhysicsStartedEvent());
		}

		public function pause():void
		{
			_runningState = PAUSED;
			this.notify(new PhysicsStoppedEvent());
		}

		//manage debug settings
		public function debug(_toggle:Boolean):void
		{
			if(_toggle)
				_debugState = DEBUG_ON;
			else
				_debugState = DEBUG_OFF;

			_world.enableDebugDraw((_debugState == DEBUG_ON));
		}

		// add or remove physics objects
		public function addPhysicsObject(_object:IPhysicsObject):void
		{
			_world.addPhysicsObject(_object);
		}

		public function removePhysicsObject(_object:IPhysicsObject):void
		{
			_world.removePhysicsObject(_object);
		}

		//update all the physics objects in the world
		public function updatePhysics(e:Event):void
		{
			switch(_runningState)
			{
				case PAUSED:
					break;
				case RUNNING:
					_world.updatePhysics(e);
					break;
			}
		}

		//accessors
		public function get factory():PhysicsFactory
		{
			return _factory;
		}

		public function get world():PhysicsWorld
		{
			return _world;
		}

		public function get utils():PhysicsUtils
		{
			return _physicsUtils;
		}
	}
}

