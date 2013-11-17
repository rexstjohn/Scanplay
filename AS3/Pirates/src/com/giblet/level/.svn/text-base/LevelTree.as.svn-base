package com.giblet.level 
{
	import Box2D.Collision.b2Bound;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import flash.display.Sprite;
	import com.core.factory.MessageFactory;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class LevelTree
	{		
		//storing objects			
		public static var basicObjects:Array;
		public static var polyObjects:Array;
		public static var lineObjects:Array;
		
		public function LevelTree() 
		{
			basicObjects = new Array();
			lineObjects = new Array();			
			polyObjects = new Array();			
		}
		
		//make sure the level has a treasure
		public static function ContainsTreasure():Boolean
		{
			var treasure:Boolean = false;
			
			for each(var i:GameObject in basicObjects)
			{
				if (i.type == "treasure")
				{
					treasure = true;
				}
			}
			
			return treasure;
		}
		
		///make sure the level has platforms
		public static function ContainsPlatforms():Boolean
		{
			return (lineObjects.length > 0);			
		}
		
		public static function AddBasicObject(l:BasicObject):void
		{
			//make sure there is not already an object in that index
			if (basicObjects.length < 55)
			{
				if (GetSquareOccupant(l.absoluteSnapPos))
				{
					BasicObject(GetSquareOccupant(l.absoluteSnapPos)).destroy();
					basicObjects.splice(basicObjects.indexOf(GetSquareOccupant(l.absoluteSnapPos)), 1);
				}
				basicObjects.push(l);
				
				//add the shape
				Main.m_sprite.addChild(l.shape);	
			}
			else
			{
				MessageFactory.CreateMessage("You have reached the limit of objects");
			}
		}
		
		//check if a square is already occupied
		public static function GetSquareOccupant(p:Point):BasicObject
		{
			var occupant:BasicObject = null;
			
			//overwrite any objec that this gets placed on top of
			for each(var g:BasicObject in basicObjects)
			{				
				if ((g.absoluteSnapPos.x == p.x) && (g.absoluteSnapPos.y == p.y))
				{
					occupant = g;
				}
			}
			
			return occupant;			
		}
		public static function AddPolygon(v:Array, type:String):void
		{			
			polyObjects.push(new PolyObject(v,type));	
			EnforceWrapping();		
		}
		
		public static function DeleteObject(s:Sprite):void
		{
		
			for each(var i:LineObject in lineObjects)
			{
				if (i.skin == s)
				{
					i.destroy();
					lineObjects.splice(lineObjects.indexOf(i), 1);
					i = null;
				}
			}
			
			for each(var g:BasicObject in basicObjects)
			{
				if (g.shape == s)
				{
					basicObjects.splice(basicObjects.indexOf(i), 1);
					g.destroy();
					g = null;
				}
			}
		}
		
		public static function AddLineObject(l:LineObject):void
		{
			if (lineObjects.length < 50)
			{
				lineObjects.push(l);
				
				//overwrite duplicate lines / overlayered lines
				for each(var g:LineObject in lineObjects)
				{
					var count:int = 0;
					for each(var p:Point in g.points)
					{
						for each(var k:Point in l.points)
						{				
							//if we count two poinst that are the same in two line objects
							//we have overlayered lines							
							if (l != g)
							{
								if ((p.x == k.x) && ( p.y == k.y))
								{
									count++;
									if (count == 2)
									{
										trace("dupe found");
										lineObjects.splice(lineObjects.indexOf(g), 1);
										g.destroy();
										g = null;
									}
								}
							}
						}
					}
				}
				
			}
			else
			{
				MessageFactory.CreateMessage("You have reached the limit of platforms");
			}
		}
		
		
		public static function ResetLevel():void
		{
			for each(var i:LineObject in lineObjects)
			{
				i.destroy();
				i = null;
			}			
			
			for each(var k:BasicObject in basicObjects)
			{
				k.destroy();
				k = null;
			}
			polyObjects = null;
			lineObjects = null;
			basicObjects = null;
			
			polyObjects = new Array();
			lineObjects = new Array();
			basicObjects = new Array();
			
		}
		
		public static function EnforceWrapping():void
		{
			//makes sure the polygons are all wrapped correctly.
			/*
			 * First, get the angle of the inner angle formed between the target point
			 * and the next two points in the series
			 * 
			 */ 
			
			for each(var l:PolyObject in polyObjects)
			{								
				//rewind the array if the points are clockwise
				if (!SignedAreaIsPositive(l.points))
				l.points.reverse();
			}
			
			//postive signed area means counter clockwise
			//negative signed area means clockwise.
			function SignedAreaIsPositive(vertices:Array):Boolean
			{
				var centroid:Point = new Point(0,0);
				var signedArea:Number = 0.0;
				var x0:Number = 0.0; // Current vertex X
				var y0:Number = 0.0; // Current vertex Y
				var x1:Number = 0.0; // Next vertex X
				var y1:Number = 0.0; // Next vertex Y
				var a:Number = 0.0;  // Partial signed area

				// For all vertices except last
				var  i:int = 0;
				
				for (i=0; i < vertices.length - 1; i++)
				{
					x0 = vertices[i].x;
					y0 = vertices[i].y;
					x1 = vertices[i+1].x;
					y1 = vertices[i+1].y;
					a = x0*y1 - x1*y0;
					signedArea += a;
					centroid.x += (x0 + x1)*a;
					centroid.y += (y0 + y1)*a;
				}

				// Do last vertex
				x0 = vertices[i].x;
				y0 = vertices[i].y;
				x1 = vertices[0].x;
				y1 = vertices[0].y;
				a = x0*y1 - x1*y0;
				signedArea += a;
				centroid.x += (x0 + x1)*a;
				centroid.y += (y0 + y1)*a;

				signedArea *= 0.5;
				centroid.x /= (6*signedArea);
				centroid.y /= (6*signedArea);
				
				return (signedArea > 0);
			}
			
		}
		
		public static function destroy():void
		{
			for each(var i:LineObject in lineObjects)
			{
				i.destroy();
			}
		}
		
		public static function RemoveBasicObject(l:GameObject):void
		{
			for (var g:int = 0; g < basicObjects.length; g++)
			{
				if (basicObjects[g] == l )
				{
					basicObjects[g].destroy();
					basicObjects[g] = null;
					basicObjects.splice(g, 1);
				}
			}
		}
	}

}