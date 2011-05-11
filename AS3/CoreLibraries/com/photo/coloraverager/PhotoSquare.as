package com.photo.coloraverager
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * A square photo pixel used by the color averager class
	 */
	public class PhotoSquare extends Sprite
	{
		public var bitmapData:BitmapData;
		public var bitmap:Bitmap;
		
		public function PhotoSquare(_width:Number = 50, _height:Number = 50) 
		{
			super();
			
			var color:Number = Math.floor(Math.random() * 0xffffff);
			graphics.beginFill(color, 1);
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();
			
			bitmap = new Bitmap();
			bitmapData = new BitmapData(_width, _height);
			bitmap.bitmapData = bitmapData;
			addChild(bitmap);
		}	
		
		//turns our color into our average color
		public function AverageColorFill():void
		{
			//graphics.clear();
			var mc:MovieClip = new MovieClip();
			mc.addChild(bitmap);
			var averageColor:Number = ColorAverager.averageBitmapColor(mc);
			
			graphics.beginFill(averageColor, 1);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();			
		}
	}
}