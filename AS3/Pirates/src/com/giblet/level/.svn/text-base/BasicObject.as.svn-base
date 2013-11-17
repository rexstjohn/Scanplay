package com.giblet.level 
{
	import com.core.ObjectPool;
	import com.giblet.tool.SnapPoint
	import com.giblet.tool.ToolBox;
	import flash.display.MovieClip;
	import flash.display.SpreadMethod;
	import com.core.factory.AssetFactory;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class BasicObject extends GameObject
	{		
		public var pos:Point;
		public var shape:Sprite;
		public var spriteID:String;
		public var absoluteSnapPos:Point;
		
		public function BasicObject(_p:Point, _type:String, _spriteID:String = null, _defaultObject:Boolean = true) 
		{
			super(_type);
			
			pos = _p;
			type = _type;
			absoluteSnapPos = new Point();
			spriteID = _spriteID;			
		
			shape = new Sprite();
			Main.m_sprite.addChild(shape);
			
			if (_defaultObject)
			{			
				SetDimensions();
				SnapToGrid();	
			}
		}
		
		protected function SetDimensions():void
		{			
			//draw a shape to represent this pbject		
			shape = ObjectPool.GetObjectAs(spriteID);
			shape.width = Grid.gridSize;
			shape.height =  Grid.gridSize;	
		}
		
		public function destroy():void
		{
			shape.visible = false;
			ObjectPool.ReturnObject(shape);
			
			shape = null;
		}
		
		
		protected function SnapToGrid():void
		{								
			shape.x = pos.x + (Grid.gridSize / 2);
			shape.y = pos.y +  (Grid.gridSize / 2);
			
			pos.x = (pos.x)/ Grid.gridSize;		
			pos.y = (pos.y)/ Grid.gridSize ;	
			absoluteSnapPos.x = SnapPoint.x();
			absoluteSnapPos.y = SnapPoint.y();		
		}	
	}
}