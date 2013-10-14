package com.giblet.tool 
{
	import adobe.utils.ProductManager;
	import com.giblet.level.BasicObject;
	import com.giblet.level.GameObject;
	import com.menu.menu.FacebookButton;
	import flash.display.Bitmap;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.filters.GlowFilter;
	import flash.ui.Mouse;
	import com.giblet.LevelEditor;
	import com.core.factory.AssetFactory;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import com.giblet.level.LevelTree;
	import com.giblet.level.Grid;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class PolygonTool
	{
		private var vertices:Array;
		private var drawing:Boolean;
		private var currentTool:Object;
		private var outline:Sprite;
		private var texture:Bitmap;
		private var stretch:Sprite;
		private var progress:Sprite;
		private var polyType:String;
		
		public function PolygonTool() 
		{
			vertices = new Array();
			drawing = true;
			progress = new Sprite();
			outline = new Sprite();
			stretch = new Sprite();
			texture = AssetFactory.GetImage("RockTexture");
			
			Main.m_sprite.addChild(outline);
			Main.m_sprite.addChild(progress);
			Main.m_sprite.addChild(stretch);
			Main.m_stage.addEventListener(MouseEvent.CLICK, handleClick);
			Main.m_stage.addEventListener(Event.ENTER_FRAME, update);
		}		
		
		public function destroy():void
		{
			Main.m_stage.removeEventListener(MouseEvent.CLICK, handleClick);
			Main.m_stage.removeEventListener(Event.ENTER_FRAME, update);
		}
		
		private function handleClick(e:MouseEvent):void
		{	
			if (ToolBox.GetTool()["type"] == "Polygon")
			{
				polyType = ToolBox.GetTool()["name"];
				
				if (Main.m_stage.mouseY < 500 && (Main.m_stage.mouseY > 60))
				{
					AddNewPoint();
				}
			}
		}
		
		private function AddNewPoint():void
		{
			var pos:Point = new Point(Main.m_sprite.mouseX, Main.m_sprite.mouseY);
			
			 pos.x -= (pos.x % Grid.gridSize);
			 pos.y -= (pos.y % Grid.gridSize);	
			
			vertices.push(pos);
						
			//check to see if the shape is closed, if its closed, stop the draw
			//stop the draw if the shape has been closed (two points
			for each(var i:Point in vertices)
			{
				for each(var g:Point in vertices)
				{
					if (vertices.lastIndexOf(i) != vertices.lastIndexOf(g))
					{
						if ((i.x == g.x) && (g.y == i.y))
						{	
							draw();
							DrawProgress();
							vertices.splice(vertices.length - 1, 1);
							LevelTree.AddPolygon(vertices, polyType);
							vertices = new Array();
						}
					}
				}
			}
		}
			
		private function DrawProgress():void
		{
			for ( var g:int = 0; g < vertices.length; g++)
			{
				//progress.graphics.beginFill(0x000000, 1);
				progress.graphics.lineStyle(2);
				progress.graphics.endFill();	
				
				//move the pen to the first vertice
				progress.graphics.moveTo(vertices[g].x, vertices[g].y);	
				
				//draw to the next line in the array
				if(g < vertices.length -1)
				progress.graphics.lineTo(vertices[g +1].x, vertices[g + 1].y);				
			}			
			
		}
		
		private function draw():void
		{
			//outline.graphics.clear();
			
			for ( var g:int = 0; g < vertices.length; g++)
			{
				//if (drawing = false)
				//outline.graphics.beginBitmapFill(texture.bitmapData);
				
				outline.graphics.lineStyle(2, 0xff0000, 1);
				outline.graphics.beginFill(0x000000, 0);
				outline.graphics.endFill();	
				
				//move the pen to the first vertice
				outline.graphics.moveTo(vertices[g].x, vertices[g].y);	
				
				//draw to the next line in the array
				if(g < vertices.length -1)
				outline.graphics.lineTo(vertices[g +1].x, vertices[g + 1].y);	
				else
				outline.graphics.lineTo(vertices[0].x, vertices[0].y);	
				
			}
								
		}

		private function update(e:Event):void
		{
			if (ToolBox.GetTool()["type"] == "Polygon")
			{
				currentTool = ToolBox.GetTool(); //get the tool we are placing
						
				if (vertices.length > 0)
				{
					stretch.graphics.clear();
					stretch.graphics.lineStyle(2);
					stretch.graphics.moveTo(vertices[vertices.length - 1].x, vertices[vertices.length - 1].y);
					stretch.graphics.lineTo(Main.m_sprite.mouseX, Main.m_sprite.mouseY);			
					DrawProgress();
				}
				else
				{
					stretch.graphics.clear();
				}
			}
		}	
		
	}

}