package com.core.util
{
	public class GraphicsUtils
	{
		public static function drawGrid(_canvas:SuperSprite, _height:int, _width:int):void
		{
			var h:int = 0;
			var h_target:int = _canvas.height;
			var w:int = 0;
			var w_target:int = _canvas.width;
			
			while(h * h_target <= h_target)
			{
				_canvas.graphics.beginFill(0x000000,1);
				_canvas.graphics.moveTo(0,h * h_target);
				_canvas.graphics.lineTo(w_target,h * h_target );
				_canvas.graphics.endFill();
				h += 1;
			}
			
			while(w * w_target <= w_target)
			{
				_canvas.graphics.beginFill(0x000000,1);
				_canvas.graphics.moveTo(w * w_target,0);
				_canvas.graphics.lineTo(w * w_target,h_target);
				_canvas.graphics.endFill();
				w += 1;
			}
		}

	}
}