package com.core.util
{
	import flash.geom.Point;
	
	public class GraphicsUtils
	{
		private static const GRID_COLOR:int = 0xFF0000;
		public static function drawGrid(_canvas:SuperSprite, _height:int, _width:int):void
		{
			var h:int = 0;
			var h_target:Number = _canvas.height;
			var w:int = 0;
			var w_target:Number = _canvas.width;
			_canvas.graphics.lineStyle(2, GRID_COLOR, 1);
			
			for(var i:int = 0; i < w_target; i+=_width)
			{
				//_canvas.graphics.lineTo(i,h_target);
				//_canvas.graphics.moveTo(i,0); 
				//_canvas.drawLine(new Point(i,0), new Point(i,h_target),1,GRID_COLOR);
			}
			
		//	_canvas.graphics.endFill();
			/*
			while(w * w_target <= w_target)
			{
				_canvas.drawLine(new Point(w * w_target), new Point(w * w_target,h_target),1,GRID_COLOR);
				w += 1;
			}*/
		}

	}
}