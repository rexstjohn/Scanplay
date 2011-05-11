package com.controls.input 
{
	import com.graphics.Circle;
	import com.text.BasicText;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class RadioButton extends Circle
	{
		protected var textField:BasicText;
		public var isSelected:Boolean;
		
		protected var selectedColor:Number = 0x00ff00;
		protected var deselectedColor:Number = 0xff0000;
		
		public function RadioButton(_text:String, _x:Number, _y:Number, _radius:Number, _color:Number = 0xff0000) 
		{
			super(_x, _y, _radius, _color);
			textField = new BasicText(_text, 20, -16);		
			isSelected = false;			
			addChild(textField);	
			SetColorOutline(deselectedColor);
			buttonMode = true;
		}
		
		public function GetText():String
		{
			return textField.text;
		}
		
		public function Show():void
		{
			visible = true;
			textField.Show();
		}
		
		public function Hide():void
		{
			visible = false;
			textField.Hide();
		}
		
		public function Select():void
		{
			isSelected = true;
			SetColorOutline(selectedColor);	
			SetColorFill(selectedColor);
		}
		
		public function DeSelect():void
		{
			isSelected = false;
			SetColorOutline(deselectedColor);			
		}
		
		protected function HandleClick(e:MouseEvent):void
		{
			if (!isSelected)
			Select();
		}
	}
}