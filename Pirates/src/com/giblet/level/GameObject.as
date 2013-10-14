package com.giblet.level 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class GameObject
	{		
		public var type:String;
		public var id:TextField = new TextField();
		
		public function GameObject(_type:String)
		{
			type = _type;
		}	
	}
}