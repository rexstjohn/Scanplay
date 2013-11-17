package com.trebuchet.controllers
{
	import com.core.interfaces.IEvent;
	import com.core.interfaces.IPhysicsObject;
	import com.core.mvc.ApplicationContext;
	import com.core.mvc.Controller;
	import com.core.ui.components.ViewNavigator;
	import com.core.util.MathUtil;
	import com.core.util.Rect2;
	import com.core.util.SuperSprite;
	import com.trebuchet.config.GameConfig;
	import com.trebuchet.events.GameEvent;
	import com.trebuchet.events.LaunchedEvent;
	import com.trebuchet.events.ReloadedEvent;

	import flash.display.PixelSnapping;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	//this is effectively the same as the camera
	public class CanvasController extends Controller
	{
		//consts
		private static const PADDING:int = 75;
		private static const DAMPING:int = 60; // 

		//instance vars
		private var _velocity:Number = 10;
		private var _canvas:SuperSprite;
		private var _target:IPhysicsObject=null;
		private var _startingPosition:Point;
		private var _viewingFrame:Rect2;

		public function CanvasController(_context:ApplicationContext)
		{
			super(_context);
		}

		public function init(_canvas:SuperSprite):void
		{
			this._canvas = _canvas;
			this._startingPosition = new Point(_canvas.x,_canvas.y);
			this._canvas.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
			this._viewingFrame = new Rect2(_canvas.x + PADDING, _canvas.y, GameConfig.STAGE_WIDTH - (PADDING *2), GameConfig.STAGE_HEIGHT);
		}

		override public function update(e:IEvent):void
		{
			//react to various menu related events here
			switch(e.type)
			{
				/* TREBUCHET EVENTS */
				case GameEvent.READY_TO_FIRE_EVENT:
					//put the camera in the start position
					break;
				case GameEvent.FIRING_EVENT:
					//track the ball with the camera
					break;
				case GameEvent.RELOADED_EVENT:
					_startingPosition.x = centerX(ReloadedEvent(e).lastProjectile.x);
					resetCamera();
					break;
				case GameEvent.LAUNCHED_EVENT:
					//track the launched event
					_target = LaunchedEvent(e).projectile;
					break;
				default:
					break;
			}
		}

		//put the camera back to the originating point
		private function resetCamera():void
		{
			_target = null; //no more tracking the target
			_canvas.x = _startingPosition.x;
			_canvas.y = _startingPosition.y;
		}

		private function handleEnterFrame(e:Event):void
		{
			//update the reference viewing rectangle
			_viewingFrame.x = (_canvas.x * -1) + PADDING;

			//if a target exists, track it (with some light damping)
			if(_target)
			{
				var distance:Number = _target.worldPosition.x - _viewingFrame.center.x;
				_canvas.x += (distance / DAMPING) * -1;
				_canvas.drawRect(_viewingFrame, .3);
			}
		}

		private function centerX(_x:Number):Number
		{
			return (_x - GameConfig.STAGE_WIDTH/2) * -1;
		}
	}
}

