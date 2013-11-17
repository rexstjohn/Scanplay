package com.core.interfaces
{
	import flash.events.MouseEvent;
	
	public interface IInteractive
	{
		function handleClick(e:MouseEvent):void;
		function handleDown(e:MouseEvent):void;
		function handleOver(e:MouseEvent):void;
		function handleOut(e:MouseEvent):void;
		function handleUp(e:MouseEvent):void;
		function handleMove(e:MouseEvent):void;
	}
}