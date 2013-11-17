package com.core.util
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Rect2 extends Rectangle
	{
		public function Rect2(x:Number=0, y:Number=0, width:Number=0, height:Number=0)
		{
			super(x, y, width, height);
		}
		public function get center():Point
		{
			return new Point(this.x + (this.width / 2), this.y + (this.height / 2));
		}

		public function set center(_point:Point):void
		{
			this.x = _point.x + this.width / 2;
			this.y = _point.y + this.height / 2;
		}
	}
}

