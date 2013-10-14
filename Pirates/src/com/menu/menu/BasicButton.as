package com.menu.menu
{
	
	import flash.display.Sprite;
	import com.menu.factory.MenuFactory;
	import com.menu.text.TextFactory;
	import com.core.factory.AssetFactory;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import com.core.factory.AssetFactory;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class BasicButton 
	{
		public var button:Sprite;
		public var text:TextField;
		public var parent:Stage;
		
		public function BasicButton(_p:Point, _text:String, _height:Number = 40, _width:Number = 190, _parent:Stage = null) 
		{
			super();
			
			button = AssetFactory.GetSprite("MenuBlockRectangle");
			text   = TextFactory.CreateTextField(_text, 26,false,false,0x5c4101);
			///configure teh text field
			button.x = text.x = _p.x;
			button.y = text.y= _p.y;		
			button.height = _height;
			button.width =  _width; // text.textWidth + 40;
			button.buttonMode = true;
			button.mouseChildren = false;
			
			text.x -= (text.textWidth / 2) ;		
			
			if (_parent == null)
			parent = Main.m_sprite.stage;
			else
			parent = _parent;
			
			parent.addChild(button);
			parent.addChild(text);
			text.y -= 18;	
			
			AssetFactory.AddShadow(button);
			button.addEventListener(MouseEvent.MOUSE_OVER, handleOver);
			button.addEventListener(MouseEvent.MOUSE_OUT, handleOut);
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
		
		public  function destroy():void
		{
			button.removeEventListener(MouseEvent.MOUSE_OVER, handleOver);
			button.removeEventListener(MouseEvent.MOUSE_OUT, handleOut);
			button.visible = false;
			text.visible = false;
			button = null;
			text = null;
		}
		
		private function handleOut(e:MouseEvent):void
		{
			button.filters = [];
			AssetFactory.AddShadow(button);	
			//button.y -= 5;
			//text.y -= 5;
		}
		
		private function handleOver(e:MouseEvent):void
		{
			//SoundFactory.PlaySound("ButtonClick");
			button.filters = [new GlowFilter(0xFFFF00, .7, 3, 3, 2, 1)];
			//button.y += 5;
			//text.y += 5;
		}
	}

}