package com.core.factory 
{
	import com.game.*;
	import com.game.ship.weapon.CannonBall;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.events.TimerEvent;
	import flash.filters.DropShadowFilter;
	import com.menu.factory.MenuFactory;
	import flash.geom.Point;
	import com.menu.text.TextFactory;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.text.TextFieldAutoSize;
	import com.core.*;
	import com.core.util.Utilities;
	import com.core.factory.AssetFactory;
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class MessageFactory 
	{
		private static var messages:Array
		private static var popUpFactory:PopUpFactory;
		
		public function MessageFactory() 
		{
			super();
			messages  = new Array();
			popUpFactory = new PopUpFactory();
			Main.m_sprite.addEventListener(Event.ENTER_FRAME, handleEnter);
		}
		
		private static var o:TextField;
		
		private function handleEnter(e:Event):void
		{
			for each(o in messages)
			{
				fadeMessages(o);
			}
		}
		
		//creates a new custom message that can be set to fade out
		public static function CreateMessage(s:String, size:int = 40, yOffest:Number = 0,  timed:Boolean = true, fadeTime:Number = 1000, hasBackdrop:Boolean = false , color:Number = 0xffffff):void
		{	
			var txt:TextField = TextFactory.CreateTextField(s, size, true, false,color);
		
			Main.m_stage.addChild(txt);
			txt.x = (Main.m_stage.stageWidth / 2 ) - (txt.textWidth / 2);
			txt.y =  Main.m_stage.stageHeight / 2;
			txt.y += yOffest;
			txt.mouseEnabled = false;
			messages.push(txt);
		}
		
		//fade the old messages
		private static function fadeMessages(t:TextField):void
		{
			t.alpha -= (30 / 3000);
			
			if (t.alpha <= 0)
			{
				if(Main.m_stage.contains(t))
				Main.m_stage.removeChild(t);
				
				t = null;
			}			
		}
		
		
		public static function HideAll():void
		{
			var t:TextField;
			
			for each(t in messages)
			{
				t.visible = false;
			}
		}
		
	}

}