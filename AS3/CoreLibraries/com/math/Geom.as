package com.math 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Geom
	{
		
		public function GetDistance(_p1:Point, _p2:Point):Number
		{
			var dy:Number = _p1.y - _p2.y;
			var dx:Number = _p1.x - _p2.x;
			var distance:Number = Math.sqrt(dy * dy + dx * dx);
			return distance;
		}
		
		public function GetAngle(_p1:Point, _p2:Point, _inRadians:Boolean = true):Number
		{
			var dy:Number = _p1.y - _p2.y;
			var dx:Number = _p1.x - _p2.x;
			var angle:Number = Math.atan2(dy, dx);
			
			if(_inRadians)
			return angle;
			else
			return angle * (Math.PI / 180);
			
		}
		
	}

}