package com.core.util
{
	import flash.geom.Point;

	public class MathUtil
	{
		public static function distance(_p1:Point, _p2:Point):Number
		{
			var dx:Number = _p1.x - _p2.x;
			var dy:Number = _p1.y - _p2.y;
			return Math.sqrt(dx*dx + dy*dy);
		}
	}
}

