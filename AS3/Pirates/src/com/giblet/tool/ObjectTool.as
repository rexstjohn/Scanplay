package com.giblet.tool 
{
	import com.giblet.level.BasicObject;
	import com.giblet.level.EnemyPirateObject;
	import com.giblet.level.GameObject;
	import com.giblet.level.NailObject;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.filters.GlowFilter;
	import flash.ui.Mouse;
	import com.giblet.LevelEditor;
	import com.core.factory.MessageFactory;
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
	public class ObjectTool
	{
		private var currentTool:Object;
		
		public function ObjectTool() 
		{			

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
			if (ToolBox.GetTool()["type"] == "Object")
			{
				//correction to prevent people from dropping shit under the tool bar
				if ((Main.m_stage.mouseY < 500) && (Main.m_stage.mouseY > 60))
				{
					var newObj:BasicObject;
					
					switch(String(currentTool.name))
					{
						case "EnemyPirate":
							newObj = new EnemyPirateObject(new Point(SnapPoint.x(), SnapPoint.y()), new String(currentTool.name), new String(currentTool["objectSpriteID"]));
							break;
						default:
							newObj = new BasicObject(new Point(SnapPoint.x(), SnapPoint.y()), new String(currentTool.name), new String(currentTool["objectSpriteID"]));
							break;
					}
					
					LevelTree.AddBasicObject(newObj);		
				}
			}
		}

		private function update(e:Event):void
		{
			if (ToolBox.GetTool()["type"] == "Object")
			{
				currentTool = ToolBox.GetTool(); //get the tool we are placing
			}
		}	
		
	}

}