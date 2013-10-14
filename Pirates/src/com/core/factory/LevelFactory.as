package com.core.factory 
{
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	
	import com.core.*;
	import com.core.factory.*;
	import com.core.util.*;
	import com.game.*;
	import com.game.blocks.*;
	import com.game.blocks.crates.*;
	import com.game.blocks.crates.powerups.*;
	import com.game.blocks.enemies.*;
	import com.game.blocks.platforms.*;
	import com.game.blocks.polygons.*;
	import com.game.fx.*;
	import com.game.objects.*;
	import com.game.ship.*;
	import com.game.ui.*;
	import com.giblet.LevelEditor;
	import com.menu.factory.*;
	import com.physics.blocks.*;
	import com.physics.GameWorld;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.utils.*;
	import mochi.as3.*;
	
	public class LevelFactory 
	{
		private static var currentLevel:Object;
		private static var background:GameBackground;
		private static var customLevelData:Object;
		
		//load a level by its index
		public static function LoadLevel(lid:int = 0, createNew:Boolean = false):void
		{				
			//get the data
			var levelData:Object            =  LoadLevelXML(lid);			 
			var newLevel:GameLevel          = new GameLevel(levelData);
			currentLevel["LevelNumber"]     = lid;	
			
			//destroy the menu, if it still exists
			MenuFactory.DestroyMenu(); //otherwise, the menu lurks with all its event listeners still firing in the background
			MenuFactory.DestroyMenuBackground(); //make sure this fucking thing is dead as a door nail. Bastard.
			
				CreateLevelObjects(levelData, "Adventure", createNew);	
			
		}
		
		//loads a custom level
		//we need to pop a dialogue and get the user to load the xml
		public static function LoadCustomLevel():void
		{			 
			var file:FileReference;
			var fileLoader:Loader;
			file = new FileReference();	
			
			//filter for xml files only
			var xmlFileTypes:FileFilter = new FileFilter("XML (*.xml)", "*.xml;");		
			file.browse([xmlFileTypes]);
			
			//once we select one, import the xml
			file.addEventListener(Event.SELECT, selectFile);			
			 
			function selectFile(e:Event):void
			{
				file.addEventListener(Event.COMPLETE, loadFile);
				file.load();
			}
			 
			function loadFile(e:Event):void
			{
				var myXML:XML = new XML(file.data);
				XML.ignoreWhitespace = true;
				var obj:Object = LoadLevelXML(0, "Custom", myXML);
				CreateCustomLevel(obj);
			}
		}
		
		public static function CreateCustomLevel(data:Object):void
		{			
			//get the data
			var levelData:Object            = data;			 
			
			//destroy the editor
			LevelEditor.destroy(false);
			
			CreateLevelObjects(levelData, "Custom", true);		
			customLevelData = levelData;
			
		}	
		
		//reloads a custom level
		public static function ReloadCustomLevel():void
		{
			
				CreateLevelObjects(customLevelData, "Custom", true);				
					
		}
		
		public static function CreateLevelObjects(levelData:Object, _levelType:String = "Adventure", _createNew:Boolean = false):void
		{
			//load the crap in the level
				var k:int = 0
				var startFocus:Point                = new Point(0, 0); //set the focal point
				var newLevel:GameLevel              = new GameLevel(levelData, _levelType);
				var nails:Array                     = new Array();
				var platformfactory:PlatformFactory = new PlatformFactory();
				
				//which background will we load
				var backgroundName:String;
				
				if (GameLevel.levelID > 20)
				backgroundName = "Arctic";
				else
				backgroundName = "Tropical";
				
				for (k; k < levelData["objects"].length; k++)
				{ 			
					var sourceObject:Object = levelData["objects"][k];		
				
					switch(String(sourceObject["type"]))
					{
						case "background":
							if (_createNew || !GameLevel.background)
							GameLevel.background = new GameBackground(backgroundName);
							else
							GameLevel.background.Show();
							break;
						case "pirateship":
							GameLevel.water = new Water(sourceObject["y"]);
							GameLevel.ship = new PirateShip(new Point(new Number(sourceObject["x"]), new Number(sourceObject["y"])));
							GameLevel.SetDefaultCameraTarget(GameLevel.ship);
							break;
						case "enemypirate":
							GameLevel.AddObject(new EnemyPirate(new Point(sourceObject["x"], sourceObject["y"])));
							break;
						case "enemycannonpirate":
							GameLevel.AddObject(new EnemyCannonPirate(new Point(sourceObject["x"], sourceObject["y"])));
							break;
						case "evilpirateship":
							GameLevel.AddObject(new EvilPirateShip(new Point(sourceObject["x"], sourceObject["y"])));
							break;
						case "drunkenseagull":
							GameLevel.AddObject(new DrunkenSeagull(new Point(sourceObject["x"], sourceObject["y"])));
							break;
						case "whale":
							GameLevel.AddObject(new Whale(new Point(sourceObject["x"], sourceObject["y"])));
							break;
						case "grog":
							GameLevel.AddObject(new Grog(new Point(sourceObject["x"], sourceObject["y"])));
							break;
						case "powderkeg":
							GameLevel.AddObject(new PowderKeg(new Point(sourceObject["x"], sourceObject["y"])));
							break;
						case "treasure":
							GameLevel.AddObject(new TreasureBox(new Point(sourceObject["x"], sourceObject["y"])));;
							break;
						case "glassblock":
							GameLevel.AddObject(new GlassBlock(new Point(sourceObject["x"], sourceObject["y"] )));
							break;
						case "woodblock":
							GameLevel.AddObject(new WoodBlock(new Point(sourceObject["x"], sourceObject["y"] )));
							break;
						case "rubbershot":
							GameLevel.AddObject(new RubberShotCrate(new Point(sourceObject["x"] , sourceObject["y"])));
							break;
						case "explosiveshot":
							GameLevel.AddObject(new ExplosiveShotCrate(new Point(sourceObject["x"] , sourceObject["y"])));
							break;
						case "tripleshot":
							GameLevel.AddObject(new TripleShotCrate(new Point(sourceObject["x"] , sourceObject["y"])));
							break;
						case "starcrate":
							GameLevel.AddObject(new StarCrate(new Point(sourceObject["x"] , sourceObject["y"])));
							break;
						case "goldcoin":
							GameLevel.AddObject(new GoldCoin(new Point(sourceObject["x"] , sourceObject["y"])));
							break;
						case "staticglassplatform":
							//GameLevel.AddObject(new Platform(new Point(sourceObject["x"], sourceObject["y"]), new Point(sourceObject["x2"], sourceObject["y2"])));
							PlatformFactory.AddPlatform(new StaticGlassPlatform(new Point(sourceObject["x"], sourceObject["y"]), new Point(sourceObject["x2"], sourceObject["y2"])));
							break;
						case "staticironplatform":
							//GameLevel.AddObject(new Platform(new Point(sourceObject["x"], sourceObject["y"]), new Point(sourceObject["x2"], sourceObject["y2"])));
							PlatformFactory.AddPlatform(new StaticIronPlatform(new Point(sourceObject["x"], sourceObject["y"]), new Point(sourceObject["x2"], sourceObject["y2"])));
							break;
						case "staticwoodenplatform":
							//GameLevel.AddObject(new Platform(new Point(sourceObject["x"], sourceObject["y"]), new Point(sourceObject["x2"], sourceObject["y2"])));
							PlatformFactory.AddPlatform(new StaticWoodenPlatform(new Point(sourceObject["x"], sourceObject["y"]), new Point(sourceObject["x2"], sourceObject["y2"])));
							break;
						case "glassplatform":
							//GameLevel.AddObject(new Platform(new Point(sourceObject["x"], sourceObject["y"]), new Point(sourceObject["x2"], sourceObject["y2"])));
							GameLevel.AddObject(new GlassPlatform(new Point(sourceObject["x"], sourceObject["y"]), new Point(sourceObject["x2"], sourceObject["y2"])));
							break;
						case "ironplatform":
							//GameLevel.AddObject(new Platform(new Point(sourceObject["x"], sourceObject["y"]), new Point(sourceObject["x2"], sourceObject["y2"])));
							GameLevel.AddObject(new IronPlatform(new Point(sourceObject["x"], sourceObject["y"]), new Point(sourceObject["x2"], sourceObject["y2"])));
							break;
						case "woodenplatform":
							//GameLevel.AddObject(new Platform(new Point(sourceObject["x"], sourceObject["y"]), new Point(sourceObject["x2"], sourceObject["y2"])));
							GameLevel.AddObject(new WoodenPlatform(new Point(sourceObject["x"], sourceObject["y"]), new Point(sourceObject["x2"], sourceObject["y2"])));
							break;
						case "focuspoint":
							startFocus.x = new Number(sourceObject["x"]) ;
							startFocus.y = new Number( sourceObject["y"]);
							break;
						case "objective":
							//a levell objective
							GameLevel.objectives.push(new String(sourceObject["event"]));
							break;
						case "nail":
							//nails are special constraints, if a nail is touching something, it is added automatically
							//as a revolute joint to that object.
							nails.push(new Nail(new Point(sourceObject["x"] , sourceObject["y"] ),false, true,false)); 
							break;
						case "cwmotornail":
							//nails are special constraints, if a nail is touching something, it is added automatically
							//as a revolute joint to that object.
							nails.push(new Nail(new Point(sourceObject["x"] , sourceObject["y"] ),true,true, true)); 
							break;
						case "ccwmotornail":
							//nails are special constraints, if a nail is touching something, it is added automatically
							//as a revolute joint to that object.
							nails.push(new Nail(new Point(sourceObject["x"] , sourceObject["y"] ), true, true,false)); 
							break;
						case "dynamicnail":
							//nails are special constraints, if a nail is touching something, it is added automatically
							//as a revolute joint to that object.
							nails.push(new Nail(new Point(sourceObject["x"] , sourceObject["y"] ),false,false,false)); 
							break;
						case "woodenpolygon":
							//build a polygon
							GameLevel.AddObject(new WoodPolygon(sourceObject["polygon"]));
							break;
						case "magnetpolygon":
							//build a polygon
							GameLevel.AddObject(new GravityPolygon(sourceObject["polygon"]));
							break;
						case "ironpolygon":
							//build a polygon
							GameLevel.AddObject(new IronPolygon(sourceObject["polygon"]));
							break;
						case "stickypolygon":
							//build a polygon
							GameLevel.AddObject(new StickyPolygon(sourceObject["polygon"]));
							break;
						case "glasspolygon":
							//build a polygon
							GameLevel.AddObject(new GlassPolygon(sourceObject["polygon"]));
							break;
						case "stickyblock":
							//build a polygon
							GameLevel.AddObject(new StickyBlock(new Point(sourceObject["x"] , sourceObject["y"] )));
							break;
						case "ironblock":
							//build a polygon
							GameLevel.AddObject(new IronBlock(new Point(sourceObject["x"] , sourceObject["y"] )));
							break;
						case "magnetblock":
							//build a polygon
							GameLevel.AddObject(new MagnetBlock(new Point(sourceObject["x"] , sourceObject["y"] )));
							break;
						default:
							break;
					}			
				}
				//add nails to all the objects
				GameLevel.platforms = PlatformFactory.GetPlatforms();
				
				//push all the platforms to the game objects
				var g:PhysicsObject;
				
				for each(g in GameLevel.platforms)
				{
					GameLevel.AddObject(g);
				    Platform2D(g).CreateDepth();
				}
				
				
				//nail all the objects
				CreateNails(nails);	
				
				//start the level with the focus
				newLevel.start(startFocus);
		}
		
		//this adds nails to all the objects that are touching nails
		public static function CreateNails(nails:Array):void
		{						
			var n:Nail;
			var g:*;
			
			for each(g in GameLevel.GetObjects())
			{
				if (g is PhysicsObject)
				{
					for each(n in nails)
					{
						if (g.canBeNailed)
						{						
							//place the nail if the objects are near eachother
							if (g is Polygon2D)
							{
								if (Utilities.IsInside(Polygon2D(g),n))
								{							
									n.AttachObject(g.GetBody());
								}						
							}
							else
							{
								if (n.GetSkin().hitTestObject(g.GetSkin()))
								{
									n.AttachObject(g.GetBody());								
								}
							}
						}
					}	
				}
			}
		}
		
		//load the level xml
		public static function LoadLevelXML(lid:int, mode:String = "Default", xmlToLoad:XML = null):Object
		{		
			var newLevelXML:XML ;
			
			///by default, we get our XML from the asset factory
			if(mode == "Default")
			{
				newLevelXML   =       AssetFactory.GetXML("Level_" + (lid));
			}
			else
			{
				//however, sometimes we want to load one from disk
				newLevelXML = xmlToLoad;
			}			
			
			var newLevel:Object    =       new Object();
			var levelContent:Array =       new Array();	
		
			//capture the level dimensions
			newLevel["levelwidth"]  =      Number(newLevelXML.@levelwidth * newLevelXML.@gridsize);
			newLevel["levelheight"] =      Number(newLevelXML.@levelheight * newLevelXML.@gridsize);
			newLevel["gridsize"]    =      int(newLevelXML.@gridsize);
			newLevel["par"]         =      Number(newLevelXML.@par);
			newLevel["id"]          =      String("Level_" + lid);
			newLevel["levelnumber"] =      Number(lid);
		
			//capture all the objects
			var g:int;
			
			for (g = 0; g < newLevelXML.levelobject.length(); g++)
			{
				var newObject:Object     = new Object();
				newObject["type"]        = String(newLevelXML.levelobject[g].@type);
				newObject["x"]           = Number(newLevelXML.levelobject[g].@x * newLevelXML.@gridsize);
				newObject["y"]           = Number(newLevelXML.levelobject[g].@y * newLevelXML.@gridsize);
				newObject["x2"]          = Number(newLevelXML.levelobject[g].@x2 * newLevelXML.@gridsize);
				newObject["y2"]          = Number(newLevelXML.levelobject[g].@y2 * newLevelXML.@gridsize);
				newObject["event"]       = String(newLevelXML.levelobject[g].@event);
				newObject["text"]        = String(newLevelXML.levelobject[g].@text);
				newObject["width"]       = Number(newLevelXML.levelobject[g].@width * newLevelXML.@gridsize);
				newObject["height"]      = Number(newLevelXML.levelobject[g].@height * newLevelXML.@gridsize);
				newLevel["points"]       = Number(newLevelXML.levelobject[g].@points);
				
				//polygons are special, we have to dump all the points into a seperate array 
				//and store it for production later
				if (newLevelXML.levelobject[g].vertex.length() > 0)
				{
					var p:Array = new Array();
					var l:int;
					
					for (l = 0; l < newLevelXML.levelobject[g].vertex.length(); l++)
					{
						var _p:Point = new Point(newLevelXML.levelobject[g].vertex[l].@x, newLevelXML.levelobject[g].vertex[l].@y);
						p.push(_p);						
					}				
					
					newObject["polygon"] = p;
				}
				
				levelContent.push(newObject);					
			}			
			
			newLevel["objects"] = levelContent;
			currentLevel = newLevel;			
	
			return newLevel
		}
		
		
	}

}