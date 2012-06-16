package com.core.mvc
{
	import com.core.interfaces.IController;
	import com.core.interfaces.IEvent;
	import com.core.interfaces.IObserver;
	import com.core.ui.components.ViewNavigator;

	public class Controller implements IController,IObserver
	{
		//view navigator
		protected var _viewNavigator:ViewNavigator;
		protected var _context:ApplicationContext;

		public function Controller(_context:ApplicationContext)
		{
			this._viewNavigator = _context.viewNavigator;
			this._context = _context;
			EventBus.instance.subscribe(this);
		}

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
	}
}

