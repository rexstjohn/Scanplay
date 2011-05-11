package com.photo.coloraverager
{
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;

	public class ColorAverager 
	{
		// Converts a movieclip to it's average color
		//
		
		public static function averageBitmapColor(mc:MovieClip):uint 
		{
			var averageColor:uint;
			var bmpData:BitmapData = new BitmapData(mc.width, mc.height);
			bmpData.draw(mc);
			var r:Number = 0;
			var g:Number = 0;
			var b:Number = 0;
			var count:Number = 0;
			var pixel:Number;
			
			for (var ix:int = 0; ix < bmpData.width; ix++)
			{
				for (var iy:int = 0; iy < bmpData.height; iy++)
				{
					pixel = bmpData.getPixel(ix, iy);
						r += pixel >> 16 & 0xFF;
						g += pixel >> 8 & 0xFF;
						b += pixel & 0xFF;
						count++;
				}
			}
			r /= count;
			g /= count;
			b /= count;
			averageColor = r << 16 | g << 8 | b;
			return averageColor;
		}


		// MOVIECLIP CHANGE COLOR
		//
		public static function change(mc:MovieClip, color:uint):void 
		{
			var newCT:ColorTransform = mc.transform.colorTransform;
			newCT.color = uint(color);
			mc.transform.colorTransform = newCT;
		}
	}
}