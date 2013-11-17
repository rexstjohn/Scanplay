package com.core.mvc
{
	import com.core.interfaces.IController;
	import com.core.ui.components.ViewNavigator;
	import com.core.util.SuperSprite;
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;

	public class ApplicationContext
	{
		private var _canvas:SuperSprite;
		private var _controllers:Array;
		private var _modelStore:Dictionary;
		private var _navigator:ViewNavigator;

		public function ApplicationContext(_canvas:SuperSprite)
		{
			this._controllers = new Array();		
			this._modelStore = new Dictionary();
			this._canvas = _canvas;
		}

		public function addModel(_model:Model, _key:String):void
		{
			_modelStore[_key] = _model;
		}

		public function getModelByName(_key:String):Model
		{
			return _modelStore[_key];
		}

		public function addController(_controller:IController):void
		{
			this._controllers.push(_controller);
		}

		public function set viewNavigator(_navigator:ViewNavigator):void
		{
			this._navigator = _navigator;
		}

		public function get viewNavigator():ViewNavigator
		{
			return _navigator;
		}
		
		public function get canvas():SuperSprite
		{
			return _canvas;
		}

		public function navigateToView(_viewName:String):void
		{
			_navigator.navigateToView(_viewName);
		}
	}
}

