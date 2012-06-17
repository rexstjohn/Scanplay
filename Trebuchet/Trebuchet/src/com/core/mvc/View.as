package com.core.mvc
{
	import com.core.interfaces.IEvent;
	import com.core.interfaces.IInteractive;
	import com.core.interfaces.IObserver;
	import com.core.interfaces.IView;
	import com.core.ui.StageDimensions;
	import com.core.util.SuperSprite;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class View extends SuperSprite implements IObserver, IView, IInteractive
	{
		private var _name:String;
		private var _children:Array;

		public function View(_name:String)
		{
			//we have to fill the sprite to ensure it will be the correct size
			this.fill(StageDimensions.STAGE_WIDTH,StageDimensions.STAGE_HEIGHT,0x00ff00,.25);
			this._name = _name;
			this._children = new Array();
			EventBus.instance.subscribe(this);

			//IInteractive methods
			addEventListener(MouseEvent.CLICK, handleClick);
			addEventListener(MouseEvent.MOUSE_DOWN, handleDown);
			addEventListener(MouseEvent.MOUSE_MOVE, handleMove);
			addEventListener(MouseEvent.MOUSE_UP, handleUp);
			addEventListener(MouseEvent.MOUSE_OUT, handleOut);
			addEventListener(MouseEvent.MOUSE_OVER, handleOver);
		}

		//IInteractive Methods
		public function handleClick(e:MouseEvent):void{}
		public function handleDown(e:MouseEvent):void{}
		public function handleMove(e:MouseEvent):void{}
		public function handleUp(e:MouseEvent):void{}
		public function handleOut(e:MouseEvent):void{}
		public function handleOver(e:MouseEvent):void{}

		public function update(e:IEvent):void
		{}

		public function beginLoad():void
		{}

		public function load():void
		{
		}

		public function unload():void
		{
			EventBus.instance.unsubscribe(this);
		}

		public function addChildView(_view:IView):void
		{
			addChild(_view as Sprite);
			_children.push(_view);
		}

		public function removeChildView(_view:IView):void
		{
			removeChild(_view as Sprite);
			_children.splic(_children.indexOf(_view),1);
		}

		override public function get name():String
		{
			return _name;
		}

		public function notify(e:IEvent):void
		{
			EventBus.instance.notify(e);
		}
		public function unsubscribe():void
		{
			EventBus.instance.unsubscribe(this);
		}
	}
}

