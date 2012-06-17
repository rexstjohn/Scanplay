package com.core.util
{
	import flash.geom.Point;
	
	public class GraphicsUtils
	{
		private static const GRID_COLOR:int = 0xFFCC00;
		public static function drawGrid(_canvas:SuperSprite, _height:int, _width:int):void
		{
			var h:int = 0;
			var h_target:int = _canvas.height;
			var w:int = 0;
			var w_target:int = _canvas.width;
			
			while(h * h_target <= h_target)
			{
				_canvas.drawLine(new Point(0,h * h_target), new Point(w_target,h * h_target));
				h += 1;
			}
			
			while(w * w_target <= w_target)
			{
				_canvas.drawLine(new Point(w * w_target), new Point(w * w_target,h_target));
				w += 1;
			}
		}

	}
}