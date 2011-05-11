package com.graphics 
{
	import flash.display.NativeMenuItem;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Square extends BasicShape
	{
		protected var squareHeight:Number;
		protected var squareWidth:Number;
		
		public function Square(_x:Number, _y:Number, _width:Number = 25, _height:Number = 25, _color:Number = 0xff0000) 
		{
			super(_x, _y);
			squareHeight = _height;
			squareWidth = _width;
			graphics.beginFill(_color, 1);
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();
		}	
		
		public function SetColorFill(_color:Number):void
		{
			graphics.clear();
			graphics.beginFill(_color, 1);
			graphics.drawRect(0, 0, squareWidth, squareHeight);
			graphics.endFill();			
		}
		
		public function SetColorOutline(_color:Number):void
		{
			graphics.clear();
			graphics.lineStyle(1,_color, 1);
			graphics.beginFill(_color, 0);
			graphics.drawRect(0, 0, squareWidth, squareHeight);
			graphics.endFill();			
		}
	}
}