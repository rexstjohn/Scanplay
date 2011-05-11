package com.text 
{
	import com.graphics.Square;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class BasicField 
	{
		private var fieldName:BasicText;
		private var entryField:TextEntryForm;
		
		public function BasicField(_x:Number, _y:Number,_fieldName:String, _emptyText:String = "Your Input Here") 
		{
			fieldName = new BasicText(_fieldName, _x, _y);
			Main.sprite.addChild(fieldName);
			
			entryField = new TextEntryForm(_emptyText, fieldName.x + (fieldName.width / 2) + 24, fieldName.y,200);
		}	
		
		public function GetFormData():String
		{
			return entryField.text;
		}
		
		//does this field have input data?
		public function HasInput():Boolean
		{
			return entryField.hasInput;
		}
		
		public function Reset():void
		{
			entryField.Reset();
		}
		
		public function Show():void
		{
			fieldName.visible = true;
			entryField.visible = true;
			entryField.Show();
		}
		public function Hide():void
		{
			fieldName.visible = false;
			entryField.visible = false;
			entryField.Hide();
		}
	}
}