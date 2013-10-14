package com.giblet.tool 
{
	import flash.events.Event;
	import com.core.GameLevel;
	import flash.display.Sprite;
	import com.core.factory.AssetFactory;
	import flash.ui.Mouse;
	import com.giblet.level.LevelTree;
	import flash.events.MouseEvent;
	import com.giblet.LevelEditor;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class DeleteTool
	{
		public function DeleteTool() 
		{
			Main.m_sprite.addEventListener(MouseEvent.CLICK, handleClick);			
		}
		
		public function destroy():void
		{
			Main.m_sprite.removeEventListener(MouseEvent.CLICK, handleClick);	
		}
		
		private function handleClick(e:MouseEvent):void
		{
			if (ToolBox.GetTool()["type"] == "Delete")
			{
				LevelTree.DeleteObject(Sprite(e.target));
			}
			
			
		}
		
	}

}