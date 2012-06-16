package com.core.ui.controls
{
	import flash.display.Sprite;
	import flash.text.FontStyle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class SuperTextField extends TextField
	{
		public function SuperTextField()
		{
			super();
			this.autoSize = TextFieldAutoSize.CENTER;
			this.mouseEnabled = false;

			var txtFormat:TextFormat = new TextFormat();
			txtFormat.align = TextFormatAlign.CENTER; 
			txtFormat.font = "Arial"; 
			this.setTextFormat(txtFormat);

		}

		public function centerTextInContainer(_canvas:Sprite):void
		{
			this.x = (_canvas.width / 2) - (this.textWidth / 2);
			this.y = (_canvas.height / 2) - (this.textHeight / 2);
		}

		override public function get height():Number{return this.textHeight;}
		override public function get width():Number{return this.textWidth;}
	}
}

