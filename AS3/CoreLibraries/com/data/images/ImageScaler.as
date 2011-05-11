package com.data.images 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * Scales a bitmap image permanently (lossy) versus a vector based scale
	 */
	public class ImageScaler
	{		
		//permanently scales a bitmap to a smaller size
		public static function ScaleBitmap(_sourceBitmap:Bitmap, _endWidth:Number, _endHeight:Number):Bitmap
		{
			var bmp:BitmapData = new BitmapData(_endWidth, _endHeight);
			var scale:Number = Math.min(bmp.width/_sourceBitmap.width, bmp.height/_sourceBitmap.height);
			bmp.draw(_sourceBitmap, new Matrix(scale, 0, 0, scale));
			
			return new Bitmap(bmp);
		}
	}

}