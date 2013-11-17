package com.giblet.tool 
{
	import com.core.ObjectPool;
	import com.giblet.level.ToolTip;
	
	import com.giblet.core.EditorController;
	import com.menu.factory.MenuFactory;
	import com.giblet.level.BasicObject;
	import com.giblet.level.GameObject;
	import flash.display.Sprite;
	import com.menu.text.TextFactory;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.filters.GlowFilter;
	import flash.ui.Mouse;
	import com.giblet.LevelEditor;
	import com.core.factory.AssetFactory;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import com.giblet.level.LevelTree;
	import com.giblet.level.Grid;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class ToolBox 
	{
		
		//array of objects to draw
		private static var objects:Array;
		private static var tip:ToolTip;
		
		//current tool
		private static var toolIndex:int;
		private static var enabled:Boolean;
		private static var currentTool:Object;
		
		//some paints
		private static var tools:Array;
		private static var visibleTools:Array;
		private static var toolbarBacking:Sprite;
		
		//scroll arrows
		private static var scrollLeft:Sprite;
		private static var scrollRight:Sprite;
		private static var scroll:String;
		
		private static var hotKeys:TextField;
		
		public function ToolBox() 
		{			
			
			toolIndex = 1;
			enabled = true;
			objects = new Array();
			tools = new Array();			
			
			//create all the objects
			AddObject("delete", "Delete", "Delete", "DeleteTool", "Delete Tool: Click to delete objects and platforms");
			AddObject("staticwoodenplatform", "WoodPlatform", "Platform", "StaticWoodPlatformTool", "Wooden Platform, static: A wood plank that is NOT affected by gravity"); //unbreakable		
			AddObject("staticironplatform", "IronPlatform", "Platform", "StaticIronPlatformTool", "Iron Platform, static: An iron platform that is NOT affected by gravity"); //unbreakable		
			AddObject("staticglassplatform", "GlassPlatform", "Platform", "StaticGlassPlatformTool", "Glass Platform, static: A glass plank that is NOT affected by gravity"); //unbreakable		
			AddObject("glassplatform", "GlassPlatform", "Platform", "GlassPlatformTool", "Glass Platform, dynamic: A glass plank that is affected by gravity"); //breakable		
			AddObject("woodenplatform", "WoodPlatform", "Platform", "WoodPlatformTool", "Wooden Platform, dynamic: A wood plank that is not affected by gravity"); //breakable		
			AddObject("ironplatform", "IronPlatform", "Platform", "IronPlatformTool", "Iron Platform, dynamic: A wood plank that is not affected by gravity"); //breakable		
			AddObject("nail", "Nail", "Nail", "Nail", "Nail: Nails an object in place but allows it to swing from the nail"); //a joint		
			AddObject("cwmotornail", "CWMotorNailTool", "Nail", "CWMotorNailTool", "Motor Nail, Clock-wise: Turns nailed objects clock wise constantly"); //a joint	
			AddObject("ccwmotornail", "CCWMotorNailTool", "Nail", "CCWMotorNailTool", "Motor Nail, Counter-Clockwise: Turns nailed objects counter clockwise constantly"); //a joint	
			//AddObject("dynamicnail", "DynamicNailTool", "Nail", "DynamicNailTool", "Dynamic Nail: Nails objects together but allows them to continue moving"); //a joint	
			AddObject("treasure", "TreasureChest", "Object", "TreasureChest", "Treasure Chest");
			AddObject("grog", "Grog", "Object", "Grog", "Grog: A barrel of Grog");	
			AddObject("powderkeg", "PowderKeg", "Object", "PowderKeg", "Powder Keg: An explosive powder keg");	
			//AddObject("whale", "Whale", "Object", "Whale", "Angry Whale: A discontent whale that shoots spiteful water geisers");	
			AddObject("enemypirate", "EnemyPirate", "Object", "EnemyPirate", "Enemy Pirate: A mean spirited evil pirate");	
			AddObject("drunkenseagull", "DrunkenSeagull", "Object", "DrunkenSeagull", "Drunken Seagull: A crazy seagull");	
			//AddObject("enemycannonpirate", "EnemyCannonPirate", "Object", "EnemyCannonPirate", "Enemy Pirate With A Cannon");	
			//AddObject("evilpirateship", "EvilPirateShip", "Object", "EvilPirateShip", "Enemy Pirate Ship");	
			AddObject("stickyblock", "StickyBlock", "Object", "StickyBlock", "Acid Block: Vaporizes cannonballs"); 
			AddObject("ironblock", "IronBlock", "Object", "IronBlock", "Iron Block, dynamic: An unbreakable, moveable block"); 	
			AddObject("magnetblock", "MagnetBlock", "Object", "MagnetBlock", "Magnet Block, static: Attracts the cannonball to it with powerful magnetic force");  
			AddObject("glassblock","GlassBlock", "Object", "GlassBlock", "Glass Block, dynamic"); //shatters on muliple impacts
			AddObject("woodblock", "WoodBlock", "Object", "WoodBlock", "Wooden Block, dynamic");  //catches fire
			//AddObject("tripleshot", "TripleShotCrate", "Object", "TripleShotCrate", "Triple Shot Power-Up Crate");      //three shots at once
			//AddObject("rubbershot", "RubberShotCrate", "Object", "RubberShotCrate", "Rubber Shot Power-Up Crate");    //bounces off things
			//AddObject("explosiveshot", "ExplosiveShotCrate", "Object", "ExplosiveShotCrate", "Explosive Shot Power-Up Crate"); //blows things up
			//AddObject("woodenpolygon", "Polygon", "Polygon", "WoodenPolygonTool", "Wooden Polygon, Dynamic: Draw whatever shape you want. It will move and break like wood"); //a polygon tool	
			//AddObject("glasspolygon", "Polygon", "Polygon", "GlassPolygonTool","Glass Polygon, Dynamic: Draw whatever shape you want. It will move and break like glass."); //a polygon tool	
			//AddObject("stickypolygon", "Polygon", "Polygon", "StickyPolygonTool","Sticky Polygon, Dynamic: Draw whatever shape you want"); //a polygon tool	
			//AddObject("ironpolygon", "Polygon", "Polygon", "IronPolygonTool","Iron Polygon, Dynamic: Draw whatever shape you want"); //a polygon tool	
			//AddObject("magnetpolygon", "Polygon", "Polygon", "MagnetPolygonTool","Magnetic Polygon, Dynamic: Draw whatever shape you want"); //a polygon tool	
			
			toolIndex = 0;					
			
			//create a backing objec to go under the toolbar
			toolbarBacking = new Sprite();
			toolbarBacking.graphics.beginFill(0x000000, .25);
			toolbarBacking.graphics.drawRect(0, 0, 800, 60);
			toolbarBacking.graphics.endFill();
			Main.m_stage.addChild(toolbarBacking);
			toolbarBacking.mouseEnabled = true;
			toolbarBacking.mouseChildren = false;
			toolbarBacking.x = 0;
			toolbarBacking.y = Main.m_stage.stageHeight - 70 ;
			
			//create the tool bar
			for each(var i:Object in objects)
			{
				//create the graphic for the tool in the tool box
				var s:Sprite = ObjectPool.GetObjectAs(i["toolSpriteID"]);
				s.name = i["name"];
				Main.m_stage.addChild(s);
		
				//set the position and height, default to the below
				s.height = s.width = Grid.gridSize;
				s.y = Main.m_stage.stageHeight - 40;
				s.x = 60 + (objects.indexOf(i) * (Grid.gridSize + (Grid.gridSize / 2)));
				
				s.buttonMode = true;
				s.mouseChildren = false;
				AssetFactory.AddShadow(s);
				
				//listeners
				s.addEventListener(MouseEvent.CLICK, handleToolClick);
				s.addEventListener(MouseEvent.MOUSE_OUT, handleOut);
				s.addEventListener(MouseEvent.MOUSE_OVER, handleOver);		
				
				switch(i["objectSpriteID"])
				{
					case "EnemyPirate":
					case "Whale":
						MovieClip(s).stop();
				}
				
				var t:Object = { type: i["type"], sprite:s, objectSpriteID:i["objectSpriteID"], name:i["name"], objectSpriteID:i["objectSpriteID"], description:i["description"]};
				tools.push(t);
			}			
			
			currentTool = tools[0];
			currentTool["sprite"].alpha = .7;
			currentTool["sprite"].filters = [new GlowFilter(0xff0000, 1, 3, 3, 2, 1)];
			
			
			//create the scroll arrows
			scrollRight = ObjectPool.GetObjectAs("ScrollArrow");
			scrollLeft = ObjectPool.GetObjectAs("ScrollArrow");
			
			scrollLeft.x = 40;
			scrollRight.x = 760;
			scrollLeft.y = scrollRight.y = 560;		
			scrollRight.buttonMode = scrollLeft.buttonMode = true
			scrollLeft.scaleX = scrollLeft.scaleY = scrollRight.scaleY = scrollRight.scaleX = .7;
			scrollLeft.alpha = scrollRight.alpha = 1;
			scrollLeft.scaleY = scrollRight.scaleY = .3;
			scrollLeft.mouseChildren = scrollRight.mouseChildren = true;
			scrollLeft.rotation = 180;
			AssetFactory.AddShadow(scrollLeft); AssetFactory.AddShadow(scrollRight);
			handleVisibility();
			Main.m_stage.addChild(scrollLeft);
			Main.m_stage.addChild(scrollRight);	
			
			tip = new ToolTip(GetTool().description);
			
			//hot key reminder
			hotKeys = TextFactory.CreateTextField("Hot Keys: \"\R\"\ to Restart The Map - \"X\" For Delete Tool", 20);
			hotKeys.x = 20;
			hotKeys.y = 120;
			Main.m_stage.addChild(hotKeys);

			scrollRight.addEventListener(MouseEvent.MOUSE_OUT, handleOut);
			scrollRight.addEventListener(MouseEvent.MOUSE_OVER, handleOver);
			scrollLeft.addEventListener(MouseEvent.MOUSE_OUT, handleOut);
			scrollLeft.addEventListener(MouseEvent.MOUSE_DOWN, setScrollLeft);
			scrollRight.addEventListener(MouseEvent.MOUSE_DOWN, setScrollRight);
			scrollLeft.addEventListener(MouseEvent.MOUSE_UP, undoScroll);
			scrollRight.addEventListener(MouseEvent.MOUSE_UP, undoScroll);
			Main.m_sprite.addEventListener(Event.ENTER_FRAME, update);
			
			Main.m_stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
		}				
		
		private static function handleKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == 82)
			{
				//restart
				LevelTree.ResetLevel();
			}
			
			if (e.keyCode == 88)
			{
				//delete tool
				SetToolByName("delete");
				
			}
		}
		static public function update(e:Event):void
		{						
			//handle smooth scrolling on mouse downs of the scroll buttons
			if (scroll == "Left")
			{
				ScrollLeft();
			}
			if (scroll == "Right")
			{
				ScrollRight();
			}
			
			if (Main.m_stage.mouseY > 470)
			{
				EditorController.scrollLocked = true;
			}
			else
			{
				EditorController.scrollLocked = false;				
			}
			
		}
		
		static private function setScrollLeft(e:MouseEvent):void { scroll="Left"}
		static private function setScrollRight(e:MouseEvent):void {scroll = "Right"}
		static private function undoScroll(e:MouseEvent):void { scroll="None"}
		
		static private function ScrollLeft():void 
		{ 
			for each(var t:Object in tools)
			{
				if (!(tools[0]["sprite"].x > ( ((Grid.gridSize /2)* tools.length - 1))))
				{
					if ((Main.m_stage.mouseY > 470))
					{
						t["sprite"].x += (Grid.gridSize /2);
						handleVisibility();
					}
				}
			}
		}
		
		
		static private function  ScrollRight():void
		{
			for each(var t:Object in tools)
			{				
				if (!(tools[tools.length - 1]["sprite"].x) < ( (Grid.gridSize /2) * tools.length - 1))
				{
					if ((Main.m_stage.mouseY > 470))
					{
						t["sprite"].x -= (Grid.gridSize /2);
						handleVisibility();
					}
				}
			}
		} 
		
		static private function handleVisibility():void
		{
			for each(var t:Object in tools)
			{				
				if(t["sprite"].x > 100 && (t["sprite"].x < 700))
					t["sprite"].visible = true;	
				else
					t["sprite"].visible = false;
			}			
		}
		
		private  static function AddObject(name:String, spriteID:String, type:String, toolsprite:String = "default", _description:String = "none"):void
		{
			var newObj:Object        = new Object();
			newObj["name"]           = name;
			newObj["objectSpriteID"] = spriteID;  //id of the sprite we are using for the object
			newObj["type"]           = type;
			newObj["toolSpriteID"]   = toolsprite; //id of the sprite we use for the tool itself
			newObj["description"]    = _description;
			objects.push(newObj);
		}		
		
		private static function handleOut(e:MouseEvent):void
		{
			e.target.y -= 5;
		}
		private static function handleOver(e:MouseEvent):void
		{
			e.target.y += 5;
		}
		
		public static function destroy():void
		{
			scrollRight.removeEventListener(MouseEvent.MOUSE_OUT, handleOut);
			scrollRight.removeEventListener(MouseEvent.MOUSE_OVER, handleOver);
			scrollLeft.removeEventListener(MouseEvent.MOUSE_OUT, handleOut);
			scrollLeft.removeEventListener(MouseEvent.MOUSE_DOWN, setScrollLeft);
			scrollRight.removeEventListener(MouseEvent.MOUSE_DOWN, setScrollRight);
			scrollLeft.removeEventListener(MouseEvent.MOUSE_UP, undoScroll);
			scrollRight.removeEventListener(MouseEvent.MOUSE_UP, undoScroll);
			Main.m_sprite.removeEventListener(Event.ENTER_FRAME, update);
			Main.m_stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			
			
			tip.destroy();
			Main.m_stage.removeChild(hotKeys);
			
			for each(var s:Object in tools)
			{
				s["sprite"].removeEventListener(MouseEvent.CLICK, handleToolClick);
				s["sprite"].removeEventListener(MouseEvent.MOUSE_OUT, handleOut);
				s["sprite"].removeEventListener(MouseEvent.MOUSE_OVER, handleOver);		
				Main.m_stage.removeChild(s["sprite"]);
			}
			
			Main.m_stage.removeChild(scrollLeft);
			Main.m_stage.removeChild(scrollRight);
			
			Main.m_stage.removeChild(toolbarBacking);
		}	
		
		private static function SetToolByName(s:String):void
		{
			for each(var i:Object in tools)
			{
				if (i["name"] == s)
				{
					tip.Set(i["description"]);
					currentTool["sprite"].alpha = 1;
					currentTool["sprite"].filters = [];
					currentTool = i;
					currentTool["sprite"].alpha = .7;
					currentTool["sprite"].filters = [new GlowFilter(0xff0000, 1, 3, 3, 2, 1)];						
				}
			}		
		}
		
		private static function handleToolClick(e:MouseEvent):void
		{	
			//handle any changes to the current tool we are using	
			for each(var i:Object in tools)
			{				
				if (e.target.name == i["name"])
				{					
					SetToolByName(i["name"]);
				}
			}						
		}		
		
		//get the current tool in use
		public static function GetTool():Object
		{
			return currentTool;
		}		

	}

}