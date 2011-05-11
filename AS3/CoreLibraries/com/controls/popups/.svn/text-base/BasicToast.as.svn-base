package com.controls.popups 
{
	import com.buttons.BasicButton;
	import com.graphics.Square;
	import com.text.BasicText;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class BasicToast extends Square
	{
		private var closeButton:BasicButton;
		private var title:BasicText;
		private var message:BasicText;
		private var backing:Sprite;
		
		public function BasicToast(_x:Number, _y:Number) 
		{
			super(_x, _y, 250, 100);
			closeButton = new BasicButton("Close", _x + width / 2, _y + 100);
			
			backing = new Sprite();
			backing.graphics.beginFill(0x00000, .2);
			backing.graphics.drawRect( -100, -100, 1000, 1000);
			backing.graphics.endFill();
			backing.mouseChildren = false;
			closeButton.addEventListener(MouseEvent.CLICK, HandleClick);
		}
		
		public function HandleClick(E:MouseEvent):void
		{
			visible = false;
			closeButton.visible = false;
			message.Hide();
			title.Hide();
			backing.visible = false;
		}
		
		public function SetMessage(_text:String):void
		{
			message = new BasicText(_text, x, y + 40, 12);
		}
		
		public function SetTitle(_text:String):void
		{
			title = new BasicText(_text, x, y, 24);
		}	
		
		public function Load():void
		{
			Main.sprite.addChild(backing);		
			Main.sprite.addChild(this);
			Main.sprite.addChild(closeButton);
			Main.sprite.addChild(message);
			Main.sprite.addChild(title);			
		}
	}
}