package com.giblet.level 
{
	import com.core.ObjectPool;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class EnemyPirateObject extends BasicObject
	{
		
		public function EnemyPirateObject(_p:Point, _type:String, _spriteID:String = null) 
		{
			super(_p, _type, _spriteID,false);
			SetDimensions();
			SnapToGrid();
		}		
		
		protected override function SetDimensions():void
		{			
			//draw a shape to represent this pbject		
			shape = ObjectPool.GetObjectAs(spriteID);
			shape.height = 100;
			shape.width = 60;
		}		
	}
}