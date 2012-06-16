package com.core.prefab
{

	import com.core.interfaces.IEvent;
	import com.core.interfaces.IObserver;
	import com.core.mvc.EventBus;

	import flash.display.Sprite;

	public class Prefab extends Sprite implements IObserver
	{
		public function Prefab()
		{
			EventBus.instance.subscribe(this);
		}

		public function update(e:IEvent):void
		{
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

