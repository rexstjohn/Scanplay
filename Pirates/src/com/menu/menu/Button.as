package com.menu.menu 
{
	import com.core.GameController;
	import com.menu.menu.MenuObject;
	import flash.display.Sprite;
	import com.menu.text.TextFactory;
	import flash.text.TextFieldAutoSize;
	import com.core.factory.AssetFactory;
	import com.core.Services;
	import com.core.factory.SoundFactory;
	import com.menu.factory.MenuFactory;
	import com.core.factory.LevelFactory;
	import com.giblet.LevelEditor;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Button extends MenuObject
	{
		//button components
		protected var button:Sprite;
		protected var text:TextField = new TextField();
		
		//buttons vars
		protected var target:String;
		protected var command:String;
		protected var state:String = "idle";
		
		public function Button(_p:Point, _txt:String, _target:String, _command:String = "LoadMenu", _buttonGraphic:String = "MenuBlockRectangle" , _center:Boolean = true, _textcolor:Number = 0x5c4101) 
		{
			super();	
			button = AssetFactory.GetSprite(_buttonGraphic);
			text   = TextFactory.CreateTextField(_txt, 26,false,false,_textcolor);
			
			//create a background graphic
			command = _command;
			target = _target;			
			
			//create the button
			text.autoSize = TextFieldAutoSize.CENTER;
			if(_center)
			button.x = text.x = Main.m_stage.stageWidth / 2;
			else
			button.x = text.x = _p.x;
			
			button.y = text.y = _p.y;		
			button.height     = text.textHeight + 30;
			button.width      = text.textWidth + 50;			
			button.mouseChildren = false;
			text.mouseEnabled = false;
			button.buttonMode = true;
			
			text.x            -= (text.textWidth / 2) ;
			text.y            -= (text.textHeight  / 2);// + 5;			
			text.y            -= text.textHeight / 5;
			
			Main.m_stage.addChild(button);		
			Main.m_stage.addChild(text);
			TextFactory.AddShadow(button);
			
			button.mouseChildren = false;
			
			button.addEventListener(MouseEvent.CLICK, handleClick);
			button.addEventListener(MouseEvent.MOUSE_OVER, handleOver);
			button.addEventListener(MouseEvent.MOUSE_OUT, handleOut);
		}
		
		public function GetButton():Sprite
		{
			return button;
		}
		
		public function GetText():TextField
		{
			return text;
		}
		
		public function destroy():void
		{	
			if (button)
			{
				button.removeEventListener(MouseEvent.CLICK, handleClick);
				button.removeEventListener(MouseEvent.MOUSE_OVER, handleClick);
				button.removeEventListener(MouseEvent.MOUSE_OUT, handleOut);
				button.visible = false;
				text.visible = false;			
					
				if (Main.m_stage.contains(button) && Main.m_stage.contains(text))
				{
					Main.m_stage.removeChild(button);
					Main.m_stage.removeChild(text);
				}
			}
			button = null;
			text = null;
		}
		
		
		public function show():void
		{
			text.visible = true;
			button.visible = true;
		}
		
		public function hide():void
		{
			text.visible = false;
			button.visible = false;
		}
		
		public function SetPosition(_p:Point):void
		{
			button.x = _p.x;
			button.y = _p.y;
			text.x = _p.x -= (text.textWidth / 2);
			text.y = _p.y -= (text.textHeight / 2);
			text.y            -= text.textHeight / 5;
		}
		
		private function handleOut(e:MouseEvent):void
		{
			button.filters = [];
			AssetFactory.AddShadow(button);	
		}
		
		private function handleOver(e:MouseEvent):void
		{
			//SoundFactory.PlaySound("ButtonClick");
			button.filters = [new GlowFilter(0xFFFF00, .7, 3, 3, 2, 1)];
		}
		
		protected function handleClick(e:MouseEvent):void
		{			
			SoundFactory.PlaySound("ButtonClick", false,false,.4);
			GameController.HandleEvent(command, target);
		}
	}

}