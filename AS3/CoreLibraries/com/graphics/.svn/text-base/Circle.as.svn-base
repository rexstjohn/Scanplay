package com.graphics 
{
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Circle extends BasicShape
	{
		protected var radius:Number;
		
		public function Circle(_x:Number, _y:Number, _radius:Number, _color:Number = 0xff0000) 
		{
			super(_x, _y);
			radius = _radius;
			
			graphics.beginFill(_color, 1);
			graphics.drawCircle(-(_radius / 2), -(_radius /2), _radius);
			graphics.endFill();
		}
		
		
		public function SetColorFill(_color:Number):void
		{
			graphics.clear();
			graphics.beginFill(_color, 1);
			graphics.drawCircle(-(radius / 2), -(radius /2), radius);
			graphics.endFill();			
		}
		
		public function SetColorOutline(_color:Number):void
		{
			graphics.clear();
			graphics.lineStyle(1,_color, 1);
			graphics.beginFill(_color, 0);
			graphics.drawCircle(-(radius / 2), -(radius /2), radius);
			graphics.endFill();			
		}
	}

}