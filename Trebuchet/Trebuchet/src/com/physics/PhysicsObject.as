package com.physics
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2JointEdge;
	import Box2D.Dynamics.b2Body;

	import com.core.interfaces.*;
	import com.core.mvc.EventBus;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class PhysicsObject implements IObserver, IInteractive, IPhysicsObject
	{
		//the box2d representation of this object
		private var _body:b2Body; //box2d body
		private var _skin:Sprite; //box2d body skin

		public function PhysicsObject()
		{
		}

		public function initialize(_body:b2Body, _skin:Sprite,_interactive:Boolean = false):void
		{
			EventBus.instance.subscribe(this);

			this._body = _body;
			this._skin = _skin;

			//interactive events to handle
			if(_interactive)
			{
				_skin.addEventListener(MouseEvent.CLICK, handleClick);
				_skin.addEventListener(MouseEvent.MOUSE_DOWN, handleDown);
				_skin.addEventListener(MouseEvent.MOUSE_MOVE, handleMove);
				_skin.addEventListener(MouseEvent.MOUSE_UP, handleUp);
				_skin.addEventListener(MouseEvent.MOUSE_OUT, handleOut);
			}
		}

		//accessors
		public function set body(_body:b2Body):void
		{
			this._body = _body;
		}

		public function get body():b2Body
		{
			return this._body;
		}

		public function set skin(_skin:Sprite):void
		{
			this._skin = _skin
		}

		public function get skin():Sprite
		{
			return this._skin;
		}


		// IObserver
		public function unsubscribe():void
		{
			EventBus.instance.unsubscribe(this);
		}

		public function notify(e:IEvent):void
		{
			EventBus.instance.notify(e);
		}

		public function update(e:IEvent):void{}

		//IInteractive Interface methods
		public function handleClick(e:MouseEvent):void{}
		public function handleDown(e:MouseEvent):void{}
		public function handleOver(e:MouseEvent):void{}
		public function handleOut(e:MouseEvent):void{}
		public function handleUp(e:MouseEvent):void{}
		public function handleMove(e:MouseEvent):void{}

		//IPhysicsObject Interface Methods:
		public function updatePhysics(e:Event):void
		{
			if(!_skin || !_body) 
				return;

			//set the position
			var pos:b2Vec2 = this._body.GetPosition();
			_skin.x = PhysicsWorld.toCanvas(pos.x);
			_skin.y = PhysicsWorld.toCanvas(pos.y);

			//set the rotation
			_skin.rotation = _body.GetAngle() * (180 / Math.PI);
		}

		public function setPosition(_x:Number,_y:Number):void
		{
			_body.SetPosition(PhysicsWorld.toWorldVec2(new Point(_x,_y)));
		}

		public function get worldPosition():Point
		{
			return new Point(_skin.x,_skin.y);
		}

		public function get worldVelocity():b2Vec2
		{
			return PhysicsWorld.toWorldVec3(body.GetLinearVelocity());
		}

		public function get x():Number{return _skin.x;}
		public function get y():Number{return _skin.y;}
	}
}

