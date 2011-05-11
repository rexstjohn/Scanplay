package com.text 
{
	import com.graphics.Square;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.text.TextFieldType;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class TextEntryForm extends BasicText
	{
		protected var formOutline:Square;
		protected var formBlankText:String;
		public var hasInput:Boolean = false;
		
		public function TextEntryForm(_text:String, _x:Number, _y:Number, _width:Number,_height:Number = 16, _size:Number = 12, _font:String = "Arial", _color:Number = 0x000000) 
		{
			super(_text, _x, _y, _size, _font, _color);
			formBlankText = _text;
			type          = TextFieldType.INPUT;
			mouseEnabled  = true;
			formOutline   = new Square(x,y,_width, _height);
			Main.sprite.addChild(formOutline);
			Main.sprite.addChild(this);
			formOutline.SetColorOutline(0xff0000);	
			
			addEventListener(TextEvent.TEXT_INPUT, HandleInput);
			addEventListener(Event.SELECT, HandleSelect);
		}
		
		public function Reset():void
		{
			text = formBlankText;
			formOutline.SetColorOutline(0xff0000);	
		}
		
		protected function HandleSelect(e:Event):void
		{
			text = "";
			setTextFormat(textFormat);
		}
		
		protected function HandleInput(e:TextEvent):void
		{
			if (text != formBlankText)
			{
				formOutline.SetColorOutline(0x00ff00);
				hasInput = true;
				setTextFormat(textFormat);
			}
		}
		
		public override function Show():void
		{
			visible = true;
			formOutline.visible = true;
		}
		
		public override function Hide():void
		{
			visible = false;
			formOutline.visible = false;
		}
		
	}
}