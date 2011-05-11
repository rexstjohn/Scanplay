package com.graphics 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Polygon extends Spline
	{		
		
		public function Polygon(_vertices:Array) 
		{
			super(_vertices);
		}
		
		public function Draw():void
		{
			graphics.beginFill(0xff0000, 1);
			graphics.moveTo(vertices[0].x, vertices[0].y);
			
			for each(var o:Point in vertices)
			{
				graphics.lineTo(o.x, o.y)
				graphics.moveTo(o.x, o.y);
				
				if (vertices.indexOf(o) == vertices.length - 1)
					graphics.lineTo(vertices[0].x, vertices[0].y);
			}			
		}
	}

}