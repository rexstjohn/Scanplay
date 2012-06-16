package com.core.ui.controls
{
	import com.core.mvc.EventBus;
	import com.core.interfaces.IEvent;
	import com.core.interfaces.IInteractive;
	import com.core.interfaces.IObserver;
	import com.core.interfaces.IView;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class GameControl extends Sprite implements IObserver, IView, IInteractive
	{
		public function GameControl()
		{
			super();
			EventBus.instance.subscribe(this);
			addEventListener(MouseEvent.CLICK, handleClick);
			addEventListener(MouseEvent.MOUSE_DOWN, handleDown);
			addEventListener(MouseEvent.MOUSE_MOVE, handleMove);
			addEventListener(MouseEvent.MOUSE_UP, handleUp);
			addEventListener(MouseEvent.MOUSE_OUT, handleOut);
			addEventListener(MouseEvent.MOUSE_OVER, handleOver);
		}
		
		//IInteractive functions
		public function handleClick(e:MouseEvent):void{}
		public function handleDown(e:MouseEvent):void{}
		public function handleMove(e:MouseEvent):void{}
		public function handleUp(e:MouseEvent):void{}
		public function handleOut(e:MouseEvent):void{}
		public function handleOver(e:MouseEvent):void{}
		
		//IObserver functions
		public function update(e:IEvent):void
		{}
		
		public function unsubscribe():void
		{
			EventBus.instance.unsubscribe(this);
		}
		
		public function notify(e:IEvent):void
		{
			EventBus.instance.notify(e);
		}
		
		//IView functions
		public function beginLoad():void{}
		public function load():void{}
		public function unload():void{}
		public function addChildView(_view:IView):void{}
		public function removeChildView(_view:IView):void{}
	}
}