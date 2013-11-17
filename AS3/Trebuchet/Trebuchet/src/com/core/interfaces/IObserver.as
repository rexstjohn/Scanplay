package com.core.interfaces
{
	import com.core.interfaces.IEvent;
	
	public interface IObserver
	{
		function update(e:IEvent):void;
		function notify(e:IEvent):void;
		function unsubscribe():void;
	}
}