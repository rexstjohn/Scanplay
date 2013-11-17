package com.giblet.util
{
	import com.giblet.level.LevelTree;
	import com.giblet.level.LineObject;
	import com.giblet.level.PolyObject;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
	import flash.geom.Point;
    import flash.utils.ByteArray;
	import com.giblet.level.Grid;
    import flash.net.FileReference;

/**
 * ...
 * @author ScanPlay Games
 * 
 * The interesting thing to note here is the zoom level. Because we are "zoomed out" to see the whole board
 * when we edit the shapes, we will run into a major problem when attempting to import that points into
 * the game: The x and y values will all be wrong but the height and width values will be correct.
 * 
 * This is a major mind fuck and has to be corrected here before we save the shapes. 
 */
public class XMLSaver 
{
		private static var _xml:XML;
		private static var saving:Boolean = false;
		
        public function XMLSaver():void
		{
		}

        public static function writeLevelData():void 
        {				
				trace("creating level data");				
				_xml = <level><levelobject type="background"/><levelobject type="water"/><levelobject type="pirateship" x="0" y="9"/></level>;
				_xml.@gridsize = 50;
				
				var farthestTreasureX:Number = 0;
				var farthestTreasureY:Number = 0;
				var treasureCount:int = 0;
				
				//write the xml for the basic objects
				for(var g:int = 0; g <  LevelTree.basicObjects.length; g++ )
				{
					var levelObj:XML;				
					
					//create the level object entry
					levelObj                    = <levelobject />;						
					//add all the attributes to it...
					levelObj.@type              = LevelTree.basicObjects[g].type;
					//levelObj.@points = LevelTree.basicObjects[g].score;
					levelObj.@x                 = LevelTree.basicObjects[g].pos.x;				
					levelObj.@y                 = LevelTree.basicObjects[g].pos.y;
					
					//we must divide all our sizes by 2 for them to be accurate
					_xml.appendChild(levelObj);		
					
					//add a "Get the treasure" objective for every treasure in the level
					if (levelObj.@type == "treasure")
					{
						var objective:XML = <levelobject type="objective" event="TreasureFound"/>;
						_xml.appendChild(objective);
						
						treasureCount++;
						
						//default the focus point to the farthest x treasure location
						if (levelObj.@x > farthestTreasureX)
						{
							farthestTreasureX = levelObj.@x;
							farthestTreasureY = levelObj.@y;
						}
					}					
					
					//add a "Get the treasure" objective for every treasure in the level
					if (levelObj.@type == "enemypirate" || levelObj.@type == "evilpirateship")
					{
						var objective2:XML = <levelobject type="objective" event="PirateKilled"/>;
						_xml.appendChild(objective2);
					}		
					//add a "Get the treasure" objective for every treasure in the level
					if (levelObj.@type == "drunkenseagull")
					{
						var objective3:XML = <levelobject type="objective" event="SeagullKilled"/>;
						_xml.appendChild(objective3);
					}					
				}
				
				//by default, add a focus point on the farthest treasure
				var focus:XML = <levelobject type="focuspoint"/>
				focus.@x = farthestTreasureX;
				focus.@y = farthestTreasureY;
				_xml.appendChild(focus);
				
				//make a guess as to par and totla shots				
				_xml.@par = treasureCount + 1;
				
				//write the xml for the line objects
				for each( var i:LineObject in LevelTree.lineObjects)
				{
					var levelLine:XML;				
					
					//create the level object entry
					levelLine = <levelobject />;						
					//add all the attributes to it...
					levelLine.@type = i.type;
					levelLine.@x = i.points[0].x / Grid.gridSize;				
					levelLine.@y = i.points[0].y/ Grid.gridSize;
					
					levelLine.@x2 = i.points[1].x/ Grid.gridSize;			
					levelLine.@y2 = i.points[1].y/ Grid.gridSize;
					_xml.appendChild(levelLine);		
				}
				
				//create the polygon
				for each(var l:PolyObject in LevelTree.polyObjects)
				{
					var newPoly:XML = <levelobject/>	;
					newPoly.@type = l.type
					
					for each(var m:Point in l.points)
					{
						var newPoint:XML = <vertex/>;
						newPoint.@x = m.x;
						newPoint.@y = m.y;
						newPoly.appendChild(newPoint);
					}
								
					_xml.appendChild(newPoly);				
				}
				
				var ba:ByteArray = new ByteArray();
				ba.writeUTFBytes(_xml);
				//ba.

				var fr:FileReference = new FileReference();
				fr.addEventListener(Event.SELECT, _onRefSelect);
				fr.addEventListener(Event.CANCEL, _onRefCancel);

				fr.save(ba, "level.xml");
			
				
        }
        private static  function _onRefSelect(e:Event):void
        {
                trace('select');
        }
        private static function _onRefCancel(e:Event):void
        {
                trace('cancel');
        }
}
}