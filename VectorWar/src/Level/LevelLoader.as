package Level 
{
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	
	import flash.display.Sprite;
	import Level.Levels.*;
	import Level.Tiles.Tile;
	import Level.Battlefield;
	import Unit.*;
	import Unit.Stationary.*;
	import Unit.Mobile.*;
	
	public class LevelLoader
	{
		public var levels:Array = [];
		public var battlefield:Battlefield;
		public var sprite:Sprite;
		
		//current level related
		public var map:Array;
		public var level:GameLevel;
		
		public const mapSize:int = 20;
		
		public function LevelLoader(s:Sprite) 
		{
			var l1:Level_1 = new Level_1();	
			levels.push(l1);	
			
			sprite = s;
		}
		
		public function loadLevel(ln:int):void
		{
			//create the game's battlefield
			battlefield = new Battlefield(sprite);
			sprite.addChild(battlefield);
			
			level = getLevelByNumber(ln);
			level.battlefield = battlefield;
			map = level.map;
			
			//first, fill the map with blocks
			fillMapWithBlocks();
			
			//handle the map's sides
			fillInSideTiles();
			
			//next, add the units and other goodies
			fillMapWithUnits();
			
			//now flip the map and orient it properly
			battlefield.rotation = 90;
			battlefield.scaleY = -1;
			
			//add the player to the stage
			createPlayer();
		}
		
		public function createPlayer():void
		{
			for (var g:* in level.units)
			{
				if (level.units[g] is SpawnPad)
				{
					var p:MegaTank = new MegaTank(level);
					p.x = level.units[g].x;
					p.y = level.units[g].y;
					level.battlefield.addChild(p);
				}
			}
		}
		
		public function fillMapWithUnits():void
		{
			var u:Unit ;
			
			//for tracking the layout of the objects
			var rowIndex:int = 0;
			var columnIndex:int = 0;
			
			//on the first pass, we lay down a bunch of block tiles.
			//if the space is a block, we block it.
			//if the space is an "other", we grass it.
			for (var g:* in map)
			{
				switch(map[g])
				{
					case "t":
						u = new Turret(level);
						createUnit();
						break;		
					case "p":
						u = new SpawnPad(level);
						createUnit();
						break;
					case "e":
						u = new SpawnPad(level);
						createUnit();
						break;
					default:
						break;
				}									
				
				rowIndex++;
				
				if (rowIndex == mapSize)
				{
					rowIndex = 0;
					columnIndex++;
				}				
			}			
			
			function createUnit():void
			{
				trace("unit created");
				u.x = columnIndex * u.width;
				u.y = rowIndex * u.height;				
				
				level.units.push(u);
			
				//add all the tiles to the stage
				for (var k:* in level.units)
				{
					battlefield.addChild(level.units[k]);
				}		
			}
		}
		
		public function fillMapWithBlocks():void
		{
			var b:Tile ;
			
			//for tracking the layout of the objects
			var rowIndex:int = 0;
			var columnIndex:int = 0;
			
			//on the first pass, we lay down a bunch of block tiles.
			//if the space is a block, we block it.
			//if the space is an "other", we grass it.
			for (var g:* in map)
			{
				switch(map[g])
				{
					case "w":
						b = new Tile("Grass");
						createTile();
						break;
					case "x":
						b = new Tile("Block");
						createTile();
						break;
					default:
						b = new Tile("Grass");
						createTile();
						break;						
				}					
				
				rowIndex++;
				
				if (rowIndex == mapSize)
				{
					rowIndex = 0;
					columnIndex++;
				}				
			}			
			
			function createTile():void
			{
				b.x = columnIndex * b.width;
				b.y = rowIndex * b.height;				
				
				level.tiles.push(b);
			
				//add all the tiles to the stage
				for (var k:* in level.tiles)
				{
					battlefield.addChild(level.tiles[k]);
				}		
			}			
		}
		
		//puts in the top, bottom, left, right areas contextually
		public function fillInSideTiles():void
		{
			for (var g:* in level.tiles)
			{
				if (level.tiles[g + 1] && level.tiles[g - 1] && level.tiles[g + mapSize] && level.tiles[g - mapSize])
				{				
					//check to the right					
					if (level.tiles[g + 1].currentLabel == "Grass")
					{
						level.tiles[g].Corners.BottomSide.visible = true;
					}
					//check the left
					if (level.tiles[g - 1].currentLabel == "Grass")
					{
						level.tiles[g].Corners.TopSide.visible = true;						
					}		
					
					//check the top
					if (level.tiles[g + mapSize].currentLabel == "Grass")
					{
						level.tiles[g].Corners.RightSide.visible = true;								
					}		
					
					//check the bottom
					if (level.tiles[g - mapSize].currentLabel == "Grass")
					{
						level.tiles[g].Corners.LeftSide.visible = true;								
					}		
				}
			}
		}
						
		public function getLevelByNumber(ln:int):GameLevel
		{
			var l:GameLevel;
			
			for (var g:* in levels)
			{
				if (levels[g].number == ln)
				{
					l = levels[g];
				}
			}
			
			return l;
		}
		
	}

}