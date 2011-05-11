package com.graphics 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * A line with multiple points on it
	 */
	public class Spline extends Sprite
	{
		protected var vertices:Array;
		
		public function Spline(_vertices:Array) 
		{			
			vertices = _vertices;
		}
		
		public function Draw():void
		{
			graphics.beginFill(0xff0000, 1);
			graphics.moveTo(vertices[0].x, vertices[0].y);
			
			for each(var o:Point in vertices)
			{
				graphics.lineTo(o.x, o.y)
				graphics.moveTo(o.x, o.y);
			}			
		}		
	}
}