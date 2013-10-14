package com.core
{
	
	import com.game.GameObject;
	import com.menu.menu.Button;
	import com.menu.menu.LevelButton;
	import com.menu.menu.Logo;
	import com.menu.menu.MenuObject;
	import com.core.user.User;
	import com.core.factory.MessageFactory;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import mochi.as3.*;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class GameMenu 
	{
		private static var menuName:String;
		private var menuObjects:Array = new Array();
		
		public function GameMenu(s:String ) 
		{
			super();
			Main.m_sprite.x = 0;
			Main.m_sprite.y = 0;
			menuName = s;
		}
		
		public function AddObject(o:*):void
		{
			trace("adding object.." + o);
			menuObjects.push(o);	
		}
		
		public function GetObjects():Array
		{
			return menuObjects;
		}
		
		public function arrangeLevelButtons():void
		{
			var row:int = 1;
			var column:int = 2;
			var padding:int = 85;
			var offset:int = 15;
			var width:int = 8;
			var xSideOffset:int = 15;
			var ySideOffset:int = 70;
			
			for each(var g:MenuObject in menuObjects)
			{
				if (g is LevelButton)
				{
					if (column < width)
					{
						LevelButton(g).SetPosition(new Point((column * padding ) + xSideOffset, (row * padding) + offset + ySideOffset));
						column++;
					}
					if (column == width)
					{
						column = 2;
						row++;
					}
				}
			}
		}
		
		public function destroy():void
		{
			while (menuObjects.length > 0)
			{
				if (menuObjects[0] is MenuObject)
				{
					menuObjects[0].destroy();				
					menuObjects[0] = null;
				}							
				
				menuObjects.splice(0, 1);					
			}
		}
	}
}