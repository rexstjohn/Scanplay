package com.buttons 
{
	import com.graphics.Square;
	import com.text.BasicText;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class BasicButton extends Square
	{
		private var text:BasicText;
		
		public function BasicButton(_text:String, _x:Number, _y:Number) 
		{
			super(_x, _y, 50, 20);
			buttonMode = true;
			
			//text field on the button
			text = new BasicText(_text, 0, 0);	
			width = text.width / 2;
			height = text.height
			addChild(text);
		}
		
	}

}