package com.giblet.level 
{
	import com.core.ObjectPool;
	import com.giblet.tool.SnapPoint;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class NailObject extends BasicObject
	{
		
		public function NailObject(_p:Point, _type:String, _spriteID:String = null) 
		{
			
			super(_p, _type, _spriteID,false);
			
			SetDimensions();
			SnapToGrid();
		}
		
		protected override function SetDimensions():void
		{		
			//draw a shape to represent this pbject			
			shape = ObjectPool.GetObjectAs(spriteID);
			shape.height = shape.width = 15;
			//shape.scaleX = shape.scaleY = 3;
		}	
		
		protected override function SnapToGrid():void
		{			
			shape.x = SnapPoint.x();
			shape.y = SnapPoint.y();
			
			pos.x = SnapPoint.x() / Grid.gridSize;		
			pos.y = SnapPoint.y() / Grid.gridSize ;
			absoluteSnapPos.x = SnapPoint.x();
			absoluteSnapPos.y = SnapPoint.y();
		}
	}

}