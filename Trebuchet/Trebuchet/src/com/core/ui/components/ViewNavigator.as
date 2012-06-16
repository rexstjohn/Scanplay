package com.core.ui.components
{
	import com.core.interfaces.IEvent;
	import com.core.interfaces.IObserver;
	import com.core.interfaces.IView;
	import com.core.mvc.EventBus;
	import com.core.util.SuperSprite;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class ViewNavigator implements IObserver 
	{
		private var _views:Array;
		private var _currentView:IView;
		private var _sprite:SuperSprite;
		
		public function ViewNavigator(_sprite:SuperSprite)
		{
			this._views = new Array();
			this._sprite = _sprite;
			EventBus.instance.subscribe(this);
		}
		
		// delegate all event handling responsibility to the mediator to seperate concerns
		public function update(e:IEvent):void
		{}
		
		public function pushView(_v:IView):void
		{
			_views.push(_v);
		}
		
		public function removeView(_v:IView):void
		{
			var index:* = _views.indexOf(_v);
			
			if(index)
				_views.splice(index,1);
		}
		
		public function navigateToView(_viewName:String):void
		{
			for each(var _v:IView in _views)
			{
				if(_v.name == _viewName)
				{
					loadView(_v)
					return;
				}
			}
		}
		
		protected function set currentView(_nextView:IView):void
		{
			if(_currentView)
			{
				_currentView.unload();
				_sprite.removeChild(_currentView as DisplayObject);
			}
			
			_currentView = _nextView;
			_currentView.load();
			_sprite.addChild(_currentView as Sprite);
			SuperSprite(_currentView).fill(_sprite.width,_sprite.height);
		}
		
		protected function loadView(_v:IView):void
		{
			currentView = _v;
		}
		
		public function notify(e:IEvent):void{}
		public function unsubscribe():void{EventBus.instance.unsubscribe(this);}
		
		public function getViewByName(_viewName:String):IView
		{
			var _view:IView;
			
			for each(var _v:IView in _views)
			{
				if(_v.name == _viewName)
				{
					_view = _v;
					break;
				}
			}
			
			return _view;
		}
	}
}