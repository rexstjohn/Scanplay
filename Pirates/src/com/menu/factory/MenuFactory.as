package com.menu.factory
{
	import adobe.utils.ProductManager;
	import com.core.*;
	import com.menu.menu.*;
	import com.game.fx.*;
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.utils.*;
	import com.core.factory.AssetFactory;
	import mochi.as3.*;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class MenuFactory
	{
		//menus xml				
		[Embed(source='_menus.xml',
        mimeType="application/octet-stream")]
		private static const _menuxml:Class; 
		
		private static var storiesShown:Array;
		private static var menus:Array;
		private static var mid:int;
		private static var currentMenu:GameMenu;
		private static var background:MenuBackground;
		private static var menuxml:XML;
		
		public function MenuFactory() 
		{
			super();
			menus        = new Array();
			storiesShown = new Array();
			
			//load the menu xml data
			var mc:ByteArray = new _menuxml();
			XML.ignoreWhitespace = true;
			var str:String = mc.readUTFBytes( mc.length );			
			menuxml = new XML(str);				
			LoadMenuXML();
		}
		
		public static function GetMenuIDByName(s:String):int
		{
			var o:int = 0;
			
			for (var g:int = 0; g < menus.length; g++)
			{
				if (menus[g]["name"] == s)
				{
					o = g;
				}
			}
			
			return o;
		}
		
		public static function LoadMenu(menuName:String, clearBackground:Boolean = false):void
		{			
			//next, create the new menu
			mid = GetMenuIDByName(menuName);			
			var newMenu:GameMenu = new GameMenu(menus[mid]["name"]);			
			LoadMenuData(newMenu, clearBackground); //load up all the menu objects
			currentMenu = newMenu;	
			currentMenu.arrangeLevelButtons();//arranges level buttons into a grid, if present
		}
		
		//a story is a type of menu that usually only is seen once by the user and then only accessed by click
		public static function LoadStory(menuName:String, clearBackground:Boolean = false, showOnce:Boolean = true):void
		{
			/*
			 * In the xml, we flag stories with a skip parameter. If a story has been shown, we automatically skip loading the story
			 * and go for the skip target instead.
			 */ 
			
			//next, create the new menu
			var skipStory:Boolean = false;
			mid = GetMenuIDByName(menuName);
			var s:String;
			
			for each(s in storiesShown)
			{
				if (s == menuName)
				skipStory = true;
			}			
			
			if (!skipStory)
			{			
				var newMenu:GameMenu = new GameMenu(menus[mid]["name"]);	
				LoadMenuData(newMenu, clearBackground); //load up all the menu objects
				currentMenu = newMenu;			
				storiesShown.push(menuName);
			}
			else
			LoadMenu(menus[mid]["skip"]); //loads the "skip target"
		}
		
		//load menu data
		private static function LoadMenuData(newMenu:GameMenu, clearBackground:Boolean = false):void
		{
			var k:Object; 
		
			for each(k in menus[mid]["objects"])
			{
				var menuObject:Object = k;				
				
				switch(String(menuObject["type"]))
				{
					case "episode":
						newMenu.AddObject(new Episode(new Point(menuObject["x"], menuObject["y"]), menuObject["text"],menuObject["command"],menuObject["target"],menuObject["locked"]));
						break;
					case "button":
						newMenu.AddObject(new Button(new Point(menuObject["x"], menuObject["y"]), menuObject["text"], menuObject["target"], menuObject["command"]));
						break;
					case "background":
						if (clearBackground)
						{
							if(background)
							background.destroy();
							
							background = new MenuBackground();
						}
						else
						{
							if(!background)
							background = new MenuBackground();
							
							background.Show();
						}
						break;
					case "soundtoggle":
						newMenu.AddObject(new SoundToggle(new Point(menuObject["x"], menuObject["y"])));
						break;
					case "logo":
						newMenu.AddObject(new Logo());
						break;
					case "textfield":
						newMenu.AddObject(new GameText(new Point(0, menuObject["y"]), menuObject["text"], menuObject["style"]));
						break;
					case "level":
						var levelOffest:int = 25;
						newMenu.AddObject(new LevelButton(new Point(menuObject["x"] - levelOffest, menuObject["y"]), menuObject["text"], menuObject["target"], menuObject["command"], int(menuObject["levelid"])));
						break;
					case "mochilogin":
						Services.ShowLoginWidget(menuObject["x"], menuObject["y"]);
						break;
					case "achievement":
						newMenu.AddObject(new Achievement(new Point(menuObject["x"] - levelOffest, menuObject["y"]), menuObject["text"], menuObject["id"]));
						break;
					case "script":
						SpeechScript.LoadScript(menuObject["id"]);
						break;
					case "facebook":
						newMenu.AddObject(new FacebookButton(new Point(menuObject["x"] - levelOffest, menuObject["y"])));
						break;
					case "graphic":
						newMenu.AddObject(new MenuGraphic(new Point(menuObject["x"] , menuObject["y"]), menuObject["id"]));
						break;
					case "redarrow":
						var arrow:MenuGraphic = new MenuGraphic(new Point(menuObject["x"], menuObject["y"]), "RedArrow");
						arrow.graphic.rotation = menuObject["angle"];
						newMenu.AddObject(arrow);
						break;
				}
			}
		}
		
		public static function DestroyMenu():void
		{			
			//destroy the last menu				
			if(currentMenu)
			currentMenu.destroy();
			currentMenu = null;
			
			ObjectPool.RunGC();
		}
		
		public static function DestroyMenuBackground():void
		{
			if(background)
			background.destroy();
			
			background = null;
		}
		
		public static function LoadMenuXML():void
		{
			var g:int;
			var k:int;
			var newObject:Object;
			
			for (k= 0 ; k < menuxml.menu.length(); k++)
			{
				//stuff for storing the level information
				var menuObject:Object = new Object();
				var menuContent:Array = new Array();	
			
				//capture the level dimensions
				menuObject["name"] = String(menuxml.menu[k].@name);
				menuObject["skip"] = String(menuxml.menu[k].@skip);
			
				//capture all the objects
				for (g = 0; g < menuxml.menu[k].menuobject.length(); g++)
				{
					newObject = new Object();
					newObject["type"]           = String(menuxml.menu[k].menuobject[g].@type);
					newObject["id"]             = String(menuxml.menu[k].menuobject[g].@id);
					newObject["x"]              = Number( menuxml.menu[k].menuobject[g].@x);
					newObject["y"]              = Number(menuxml.menu[k].menuobject[g].@y);
					newObject["target"]         = String(menuxml.menu[k].menuobject[g].@target);
					newObject["command"]        = String(menuxml.menu[k].menuobject[g].@command);
					newObject["text"]           = String(menuxml.menu[k].menuobject[g].@text);
					newObject["width"]          = Number(menuxml.menu[k].menuobject[g].@width);
					newObject["height"]         = Number(menuxml.menu[k].menuobject[g].@height);
					newObject["style"]          = String(menuxml.menu[k].menuobject[g].@style);
					newObject["locked"]         = String(menuxml.menu[k].menuobject[g].@locked);
					newObject["levelid"]        = int(menuxml.menu[k].menuobject[g].@levelid);
					menuContent.push(newObject);					
				}			
				
				menuObject["objects"] = menuContent;
				menus.push(menuObject);
			}
		}		

		public static function destroy():void
		{
			while (Main.m_sprite.numChildren > 0)
			{
				Main.m_sprite.removeChildAt(0);
			}
			
			currentMenu = null;
		}
	}
}