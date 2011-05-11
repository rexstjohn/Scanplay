package com.controls.input 
{
	import com.text.BasicText;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class RadioButtonList extends EventDispatcher
	{
		private var title:BasicText;
		private var options:Array;
		private var x:Number;
		private var y:Number;
		private var radioButtonRadius:Number = 10;
		
		public function RadioButtonList(_title:String, _x:Number, _y:Number) 
		{
			x = _x;
			y = _y;
			options = new Array();
			title = new BasicText(_title, _x, _y,12,"Arial",0x00000, "Left");
			Main.sprite.addChild(title);
		}
		
		public function Reset():void
		{
			for each(var o:RadioButton in options)
			{
				o.DeSelect();
			}
		}
		
		public function Show():void
		{
			title.Show();
			
			for each(var o:RadioButton in options)
			{
				o.Show();
			}
		}
		
		public function Hide():void
		{
			title.Hide();
			
			for each(var o:RadioButton in options)
			{
				o.Hide();
			}
		}
		
		public function AddOption(_text:String):void
		{
			options.push(new RadioButton(_text, x,title.y + 50 + (options.length * (radioButtonRadius * 3)) + 10, 10));
			options[options.length - 1].addEventListener(MouseEvent.CLICK, HandleSelection);
			Main.sprite.addChild(options[options.length - 1]);
		}		
		
		public function HandleSelection(e:MouseEvent):void
		{
			if (e.target is RadioButton)
			RadioButton(e.target).Select();
			
			for each(var o:RadioButton in options)
			{
				if (o != e.target)
				o.DeSelect();
			}
			
			dispatchEvent(new Event("SelectionMade"));
		}
		
		public function HasInput():Boolean
		{
			var o:Boolean = false;
			
			for each(var k:RadioButton in options)
			{
				if (k.isSelected)
				o = true;
			}
			
			return o;
		}
		
		public function GetSelection():String
		{
			var o:RadioButton;
			
			for each(var k:RadioButton in options)
			{
				if (k.isSelected)
				o = k;
			}
			
			return o.GetText();
		}
	}
}