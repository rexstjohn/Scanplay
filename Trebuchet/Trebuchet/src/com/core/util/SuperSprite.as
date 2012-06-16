package com.core.util
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class SuperSprite extends Sprite
	{
		public function SuperSprite()
		{
			super();
		}

		public function get center():Point
		{
			return new Point(this.x + (this.width / 2), this.y + (this.height / 2));
		}

		public function set center(_point:Point):void
		{
			this.x = _point.x + (this.width / 2);
			this.y = _point.y + (this.height / 2);
		}

		public function drawLine(_p1:Point, _p2:Point,_alpha:Number = 1, _color:int = 0x00FF00):void
		{
			graphics.beginFill(_color,_alpha);
			graphics.moveTo(_p1.x, _p1.y); 
			graphics.lineTo(_p2.x, _p2.y);
			graphics.endFill();
		}

		public function drawRect(_rect:Rectangle, _alpha:Number = 1, _color:int = 0x00FF00):void
		{
			graphics.beginFill(_color,_alpha);
			graphics.drawRect(_rect.x,_rect.y,_rect.width,_rect.height);
			graphics.endFill();
		}

		public function fill(_width:Number,_height:Number, _color:int = 0x00FF00, _alpha:Number = 1):void
		{
			graphics.beginFill(_color,_alpha);
			graphics.drawRect(0,0,_width,_height);
			graphics.endFill();
		}

		public function outline(_color:int = 0xFFCC00,_thickness:int =2, _alpha:Number = 1):void
		{
			graphics.lineStyle(_thickness,_color);
			graphics.drawRect(0,0,this.width,this.height);
			graphics.endFill();
		}
	}
}

