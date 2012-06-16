package com.core.mvc
{
	import com.core.interfaces.IEvent;
	import com.core.interfaces.IObserver;

	public class EventBus
	{
		private static var _instance:EventBus;
		private static var _allowInstantiation:Boolean;
		private var _subscribers:Array;

		public function EventBus()
		{
			if (!_allowInstantiation) 
				throw new Error("Error: Instantiation failed: Use SingletonDemo.getInstance() instead of new.");

			_subscribers = new Array();
		}

		public static function get instance():EventBus 
		{
			if (_instance == null) 
			{
				_allowInstantiation = true;
				_instance = new EventBus();
				_allowInstantiation = false;
			}

			return _instance;
		}

		public function subscribe(_observer:IObserver):void
		{
			_subscribers.push(_observer);
		}

		public function unsubscribe(_observer:IObserver):void
		{
			var index:int = _subscribers.indexOf(_observer);

			if(index)
				_subscribers.splice(index,1);
		}

		public function notify(e:IEvent):void
		{
			for(var i:int = 0; i < _subscribers.length; i++)
			{
				IObserver(_subscribers[i]).update(e);
			}
		}
	}
}

