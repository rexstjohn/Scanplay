package com.menu.menu 
{
	import com.core.factory.AssetFactory;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import com.menu.text.TextFactory;
	import flash.text.TextFieldAutoSize;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class GameText extends MenuObject
	{
		private var text:TextField;
		private var backing:Sprite;
		
		public function GameText(_pos:Point, _text:String, _style:String) 
		{			
			text                   = TextFactory.CreateTextField(_text);
			text.autoSize          = TextFieldAutoSize.CENTER;
			text.x                 -= text.textWidth / 2;			
			
			backing = AssetFactory.GetSprite("MenuBlockWoodRectangle");
			backing.x = text.x     = Main.m_stage.stageWidth / 2;
			backing.y = text.y     = _pos.y - 10;		
			backing.height         = text.textHeight + 30;
			backing.width          = text.textWidth + 50;			
			backing.mouseChildren  = false;
			text.mouseEnabled      = false;
			backing.buttonMode     = false;
			
			Main.m_stage.addChild(backing);
			Main.m_stage.addChild(text);			
			
			switch(_style)
			{
				case "title":
					//backing.visible = false;
					break;
				case "subtext":
					backing.visible = false;
					text.scaleX = text.scaleY = .8;
					break;
				case "smalltext":
					text.scaleX = text.scaleY =  .7;
					backing.height         = text.textHeight + 5;
					backing.width          = text.textWidth + 5;
					backing.visible  = false;
					text.x += 11;
					text.y += 3;
					break;
					
			}
		
			text.x            -= (text.textWidth / 2) ;
			text.y            -= (text.textHeight  / 2);
		}		
		
		public function show():void
		{
			text.visible = true;
			backing.visible = true;
		}
		
		public function hide():void
		{
			text.visible = false;
			backing.visible = false;
			
		}
		public function destroy():void
		{
			text = null;
			backing = null;
		}
	}
}