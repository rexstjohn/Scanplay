package com.controls.input 
{
	import com.graphics.Square;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * A sliding bar with a percentage attribute. Default is verticle
	 */
	public class Slider extends Sprite
	{
		protected var slider:Square;
		private var track:Square;
		protected var mouseDown:Boolean = false;
		protected var parentSprite:Sprite; 
		protected var percentage:Number = .5;
		
		public function Slider(_x:Number, _y:Number) 
		{
			super();
			
			slider = new Square(0,0, 25, 25);
			track  = new Square(0,0, 30, 200);
			
			track.alpha = .2;
			addChild(track);
			addChild(slider);
			
			track.mouseEnabled = false;
			slider.buttonMode = true;
			slider.mouseChildren = true;
			slider.addEventListener(MouseEvent.MOUSE_DOWN, HandleDown);
		}
		
		public function Load(_parent:Sprite):void
		{
			parentSprite = _parent;
			parentSprite.addChild(this);
			parentSprite.addEventListener(Event.ENTER_FRAME, Update);
			parentSprite.addEventListener(MouseEvent.MOUSE_UP, HandleUp);
		}
		
		protected function Update(e:Event):void
		{
			if (mouseDown)
			{
				slider.x = 0;	
				slider.y = parentSprite.mouseY;
				//percentage = height / slider.y;
				
				trace(slider.y);
				trace(percentage);
			}
		}
		
		public function GetPercentage():Number
		{
			return percentage;
		}
		
		protected function HandleDown(e:MouseEvent):void
		{
			mouseDown = true;
			slider.x = 0;	
		}
		
		protected function HandleUp(e:MouseEvent):void
		{
			mouseDown = false;
			slider.x = 0;	
		}
	}

}