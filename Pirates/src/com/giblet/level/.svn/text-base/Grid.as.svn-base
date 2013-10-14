package com.giblet.level 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import com.core.factory.AssetFactory;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class Grid
	{
		public  static var gridColumns:int = 100;
		public  static var gridRows:int = 100;
		
		//size of the active space
		public  static var gridSize:int;
		public static var levelRows:int;
		public static var levelColums:int;		
		public static var gridBG:Sprite;
		
		private static var bgColor:Number = 0xCCCCCC;	
		private static var gridColor:Number = 0xD3D3D3;	
		private static var pirate:Sprite;
		
		public function Grid(_rows:Number = 24, _columns:Number = 40, _gridsize:Number = 50) 
		{			
			levelRows = _rows;
			levelColums = _columns;
			gridSize =  _gridsize;
			gridBG = new Sprite();
			init();	
		}
		
		public static function destroy():void
		{
			Main.m_sprite.removeChild(gridBG);
			Main.m_sprite.removeChild(pirate);
			
			gridBG = null;
			pirate = null;
		}
		public static function init():void
		{
			//draw the lines of the grid		
			//lines.mouseEnabled = false;
			Main.m_sprite.addChild(gridBG);
			gridBG.graphics.lineStyle(.25, gridColor);	
			
			gridBG.graphics.beginFill(0x00000, 0);
			gridBG.graphics.drawRect( -1000, -1000, 3000, 3000);
			gridBG.graphics.endFill();
			gridBG.buttonMode = true;
			gridBG.mouseEnabled = false;
			
			///draw the rows
			for (var g:int = -1000; g < gridRows; g++)
			{								
				gridBG.graphics.moveTo(-(gridSize*gridRows), g*gridSize);		
				gridBG.graphics.lineTo((gridSize*gridRows),  g*gridSize);
			}
			
			//draw the columns
			for (var k:int = -1000; k < gridRows; k++)
			{								
				gridBG.graphics.moveTo(k*gridSize,-(gridSize*gridColumns));		
				gridBG.graphics.lineTo(k*gridSize, (gridSize*gridColumns));
			}
			
			gridBG.alpha = .33;
			
			pirate = AssetFactory.GetSprite("PirateShip");
			Main.m_sprite.addChild(pirate);
			pirate.x = 0;
			pirate.y = 9 * 50;
			pirate.scaleX = pirate.scaleY = .2;
		}
	}

}