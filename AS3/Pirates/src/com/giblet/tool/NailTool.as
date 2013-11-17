package com.giblet.tool 
{
	import com.giblet.level.BasicObject;
	import com.giblet.level.LevelTree;
	import com.giblet.level.NailObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class NailTool
	{
		private var currentTool:Object;
		
		public function NailTool() 
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
			if (ToolBox.GetTool()["type"] == "Nail")
			{
				//correction to prevent people from dropping shit under the tool bar
				if (Main.m_stage.mouseY < 500 && (Main.m_stage.mouseY > 60))
				{
					var newObj:NailObject = new NailObject(new Point(Main.m_sprite.mouseX, Main.m_sprite.mouseY), new String(currentTool.name), new String(currentTool["objectSpriteID"]));
					LevelTree.AddBasicObject(newObj);
					Main.m_sprite.addChild(newObj.shape);	
				}
			}
		}

		private function update(e:Event):void
		{
			if (ToolBox.GetTool()["type"] == "Nail")
			{
				currentTool = ToolBox.GetTool(); //get the tool we are placing
			}
		}	
		
	}

}