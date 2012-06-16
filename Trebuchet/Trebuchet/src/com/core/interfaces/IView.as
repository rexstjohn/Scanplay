package com.core.interfaces
{
	public interface IView
	{
		function beginLoad():void;
		function load():void;
		function unload():void;
		function get name():String;
		function addChildView(_view:IView):void;
		function removeChildView(_view:IView):void;
	}
}