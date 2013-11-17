package com.core.mvc
{
	import com.core.mvc.EventBus;
	import com.core.interfaces.IEvent;
	import com.core.interfaces.IModel;
	import com.core.interfaces.IObserver;

	public class Model implements IModel,IObserver
	{
		public function Model()
		{
		}

		public function save():void
		{
		}
		
		public function load():void
		{
		}
		
		public function clear():void
		{
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