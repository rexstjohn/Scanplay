package com.giblet.tool 
{
	import com.physics.GameWorld;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class SnapPoint
	{
		public static var guideSquare:Sprite;
		public static var snapPoint:Sprite;
		
		public function SnapPoint() 
		{			
			//create the guide
			guideSquare = new Sprite();
			guideSquare.graphics.beginFill(0x000000, .3);
			guideSquare.graphics.drawRect(0, 0, GameWorld.GridSize, GameWorld.GridSize);
			guideSquare.graphics.endFill();
			
			//create an indicator about where the item will get dropped
			snapPoint = new Sprite();
			snapPoint.graphics.lineStyle(1,0x00ff00);
			snapPoint.graphics.beginFill(0xff0000);
			snapPoint.graphics.drawCircle(0,0,5);
			snapPoint.graphics.endFill();
			snapPoint.mouseEnabled = false;
			snapPoint.visible = false;
			
			Main.m_sprite.addChild(snapPoint);			
			Main.m_sprite.addChild(guideSquare);
			
			Main.m_sprite.addEventListener(MouseEvent.MOUSE_MOVE, handleMove);
		}
		
		public static function GetPosition():Point
		{
			return (new Point(snapPoint.x, snapPoint.y));
		}
		
		public static function x():Number
		{
			return snapPoint.x;
		}
		
		public static function y():Number
		{
			return snapPoint.y;
		}
		
		//move a snap point so people know where they are drawing
		private static function handleMove(e:MouseEvent):void
		{				
			if (ToolBox.GetTool()["type"] != "Object")
			guideSquare.visible = false;
			else
			guideSquare.visible = true;
			
			snapPoint.x = Main.m_sprite.mouseX;
			snapPoint.y = Main.m_sprite.mouseY;
			
			//get the nearest vertex
			if((Main.m_sprite.mouseX % GameWorld.GridSize) < (GameWorld.GridSize / 2))			
			snapPoint.x -= (Main.m_sprite.mouseX % GameWorld.GridSize);
			else	
			snapPoint.x +=  GameWorld.GridSize - (Main.m_sprite.mouseX % GameWorld.GridSize);
			
			
			if((Main.m_sprite.mouseY % GameWorld.GridSize) < (GameWorld.GridSize / 2))	
			snapPoint.y -= (Main.m_sprite.mouseY % GameWorld.GridSize);	
			else
			snapPoint.y += GameWorld.GridSize - (Main.m_sprite.mouseY % GameWorld.GridSize);
			
			
			snapPoint.visible = true;			
			guideSquare.x = snapPoint.x;
			guideSquare.y = snapPoint.y;
		}
		
		public static function destroy():void
		{
			Main.m_sprite.removeEventListener(MouseEvent.MOUSE_MOVE, handleMove);
			snapPoint = null;
			guideSquare = null;
		}
	}

}