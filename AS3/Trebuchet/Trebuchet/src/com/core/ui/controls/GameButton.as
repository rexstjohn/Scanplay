package com.core.ui.controls
{
	import com.core.interfaces.IEvent;

	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;

	public class GameButton extends GameControl
	{
		private const DEFAULT_HEIGHT:int = 50;
		private const DEFAULT_WIDTH:int =  150;
		private const DEFAULT_COLOR:int =  0xFF0000;
		private var _label:SuperTextField;
		private var _event:IEvent;

		public function GameButton(_point:Point, _text:String, _event:IEvent)
		{
			//create the button
			graphics.beginFill(DEFAULT_COLOR); // choosing the colour for the fill, here it is red
			graphics.drawRect(0,0,DEFAULT_WIDTH,DEFAULT_HEIGHT); // (x spacing, y spacing, width, height)
			graphics.endFill(); 

			//set the position
			this.x = _point.x - DEFAULT_WIDTH / 2;
			this.y = _point.y - DEFAULT_HEIGHT / 2;

			//add the label
			_label = new SuperTextField();
			_label.text = _text;
			addChild(_label);
			_label.centerTextInContainer(this);
			this._event = _event;

			this.buttonMode = true;
		}

		//IInteractive functions
		override public function handleClick(e:MouseEvent):void
		{
			notify(_event);
		}
	}
}

