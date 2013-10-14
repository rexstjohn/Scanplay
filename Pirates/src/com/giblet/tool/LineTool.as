package com.giblet.tool 
{
	import com.core.ObjectPool;
	import com.giblet.level.GameObject;
	import com.giblet.level.LineObject;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;
	import com.giblet.level.Grid;
	import com.core.factory.AssetFactory;
	import com.giblet.level.LevelTree;
	import com.giblet.LevelEditor;
	import flash.text.TextField;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class LineTool
	{
		private static var drawing:Boolean;
		private static var points:Array;
		
		//array of objects to draw
		private var lines:Array;
		private var sprites:Array;
		
		//sometimes we draw different types of platforms
		private var platformTypeName:String;
		private var platformSpriteID:String;
		
		public var skin:Sprite;
		
		public function LineTool() 
		{
			lines = new Array();
			points = new Array();
			sprites = new Array();
			drawing = false;		
			
			Main.m_sprite.addEventListener(Event.ENTER_FRAME, update);
			Main.m_sprite.addEventListener(MouseEvent.CLICK, handleClick);
		}
		
		public function destroy():void
		{
			Main.m_sprite.removeEventListener(MouseEvent.CLICK, handleClick);
			Main.m_sprite.removeEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void
		{
			if (ToolBox.GetTool()["type"] == "Platform")
			{											
				platformTypeName = ToolBox.GetTool()["name"];
				platformSpriteID = ToolBox.GetTool()["objectSpriteID"];
				drawProgress();
				clearProgress();					
			}
			else
			{
				drawing = false;
				points = new Array();
				lines = new Array();
				
				if ( skin && Main.m_sprite.contains(skin))
				Main.m_sprite.removeChild(skin);
			}						
		}
		
		private function clearProgress():void
		{
			while (sprites.length > 1)
			{
				if (Main.m_sprite.contains(sprites[0].skin))
				Main.m_sprite.removeChild(sprites[0].skin);
				
				if(sprites[0].nail)
				Main.m_sprite.removeChild(sprites[0].nail);
				
				sprites.splice(0, 1);						
			}
			
			if (!drawing)
			{
				while (sprites.length >= 1)
				{
					if (Main.m_sprite.contains(sprites[0].skin))
					Main.m_sprite.removeChild(sprites[0].skin);
					
					if(sprites[0].nail)
					Main.m_sprite.removeChild(sprites[0].nail);
					
					sprites.splice(0, 1);						
				}
				
			}
		}
		
		private function drawProgress():void
		{			
			if (drawing)
			{
				
				if (Main.m_stage.mouseY < 500)
				{
					var dx:Number = (points[0].x) - (Main.m_sprite.mouseX);
					var dy:Number = (points[0].y) - (Main.m_sprite.mouseY);
					var _length:Number = Math.sqrt(dx * dx +dy * dy);
					var angle:Number = Math.atan2(dy, dx) * ( 180 / Math.PI);		
					
					//make sure we arent dropping a line smaller than a grid increment
						
						skin = ObjectPool.GetObjectAs(platformSpriteID);	
					
						//now make it pretty
						skin.width =  (_length ) + 5;
						skin.height = 10;
						skin.mouseEnabled = false;
						skin.mouseChildren = true;
					
						skin.x = (points[0].x);
						skin.y = (points[0].y);
						
						skin.rotation = angle;
						var radAngle:Number = (Math.PI / 180) * angle;
						
						skin.x -= Math.cos(radAngle) * _length / 2;			
						skin.y -= Math.sin(radAngle) * _length / 2;
						
						var obj:Object = new Object();
						obj.skin = skin;
						
						//create a nail at both ends				
						if (platformTypeName.search("static") != -1)
						{
							var nail:Sprite = ObjectPool.GetObjectAs("Nail");	
							nail.x = (skin.x );
							nail.y = (skin.y );		
							obj.nail = nail;		
							Main.m_sprite.addChild(nail);
						}
						
						Main.m_sprite.addChild(skin);				
						sprites.push(obj);
				}
			}
		}
		
		private function resetLine():void
		{			
			
			//clear the stretch drawing
			clearProgress();
			
			points = new Array();				
		}
		
		private function drawAll():void
		{			
			for each(var i:LineObject in lines)
			{
				i.draw();
			}
		}
		
		private function handleClick(e:MouseEvent):void
		{
			//make sure the user isn't dropping points below the toolbar line
			if ((Main.m_stage.mouseY < 550) && (ToolBox.GetTool()["type"] == "Platform"))
			{
				//automatically save the line if there are two points in it
				if (points.length < 2)
				{								
					//snap the shape
					var pos:Point = SnapPoint.GetPosition();
					points.push(pos);	
					
					if(points.length == 1)
					drawing = true;	
				}
				if(points.length == 2)
				{
					//make sure we aren't dropping a line that is 1 point long				
					var np:LineObject = new LineObject(points,ToolBox.GetTool());
					LevelTree.AddLineObject(np);
					lines.push(np);			
			
					drawing = false;
					resetLine();					
				}
			}
		}
		
	}

}