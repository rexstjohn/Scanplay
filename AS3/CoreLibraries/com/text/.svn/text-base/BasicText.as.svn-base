package com.text 
{
	import flash.text.Font;
	import flash.text.FontStyle;
	import flash.text.FontType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class BasicText extends TextField
	{
		protected var textFormat:TextFormat;
		
		public function BasicText(_text:String, _x:Number, _y:Number,_size:Number = 12, _font:String = "Arial", _color:Number = 0x000000, _alignment:String = "Center") 
		{
			super();
			
			textFormat  = new TextFormat();
			textFormat.size = _size;
			textFormat.color = _color;
			textFormat.font = "Arial";
			
			switch(_alignment)
			{
				case "Center":
					autoSize = TextFieldAutoSize.CENTER;
					break;
				case "Left":
					autoSize = TextFieldAutoSize.LEFT;
					break;
			}
			text = _text;
			setTextFormat(textFormat);
			wordWrap = true;
			mouseEnabled = false;
			x = _x;
			y = _y;
			width = 12 * text.length + 1;
			height = textHeight;
		}
		
		public function Show():void
		{
			visible = true;
		}
		public function Hide():void
		{
			visible = false;
		}
		
		public function SetText(_text:String):void
		{
			text = _text;
			setTextFormat(textFormat);			
		}
	}

}