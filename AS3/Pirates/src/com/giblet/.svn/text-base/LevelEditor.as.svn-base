package com.giblet 
{
	import com.giblet.tool.SnapPoint;
	import com.giblet.core.*;
	import com.giblet.level.*;
	import com.giblet.tool.*;
	import com.giblet.util.*;
	import com.menu.factory.*;
	import com.core.*;
	import com.core.factory.*;
	import com.menu.menu.*;
	import com.game.ui.*;
	import mochi.as3.MochiEvents;
	import flash.events.*;
	import flash.geom.*;
	import flash.ui.*;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class LevelEditor 
	{
		public static var controller:EditorController;
		public static var xmlSaver:XMLSaver;
		public static var exitButton:BasicButton;
		public static var saveButton:BasicButton;
		public static var resetButton:BasicButton;
		public static var loadButton:BasicButton;
		public static var grid:Grid;		
		
		//my tools
		private static var toolBox:ToolBox;
		private static var lineTool:LineTool;
		private static var deleteTool:DeleteTool;
		private static var objectTool:ObjectTool;
		private static var nailTool:NailTool;
		private static var polygonTool:PolygonTool;
		public static var snapPoint:SnapPoint;
		
		//other stuff
		private static var levelTree:LevelTree;
		private static var background:MenuBackground;
		
		public function LevelEditor() 
		{
			super();
		}
		
		public static function LoadEditor():void
		{			
			
			MochiEvents.trackEvent('Level Editor Loaded');
			background = new MenuBackground();
			
			//load all the shit we need to run the editor
			 grid = new Grid(); //grid for drawing and snapping on			 			 
			 
			//create all the stuff
			toolBox = new ToolBox();
			levelTree = new LevelTree(); //hold all the level objects prior to write			
			lineTool = new LineTool(); //better known as the platform tool
			objectTool = new ObjectTool();
			deleteTool = new DeleteTool();
			nailTool = new NailTool();
			polygonTool = new PolygonTool();
			snapPoint = new SnapPoint();
			
			//some more toop;s
			controller = new EditorController();
			xmlSaver = new XMLSaver();					
			Services.HideLoginWidget(); //hide the mochi
			
			//button for escaping
			exitButton = new BasicButton(new Point(700, 30), "Exit To Menu", 40, 160, Main.m_stage);
			saveButton = new BasicButton(new Point(500, 30), "Save Level", 40, 160, Main.m_stage);
			resetButton = new BasicButton(new Point(300, 30), "Reset", 40, 160, Main.m_stage);
			loadButton = new BasicButton(new Point(100, 30), "Play Level", 40, 160, Main.m_stage);
			exitButton.button.addEventListener(MouseEvent.CLICK, handleClick);
			saveButton.button.addEventListener(MouseEvent.CLICK, handleClick);		
			resetButton.button.addEventListener(MouseEvent.CLICK, handleClick);			
			loadButton.button.addEventListener(MouseEvent.CLICK, handleClick);			
		}
		
		public static function handleClick(e:MouseEvent):void
		{
			if (e.target == resetButton.button)
			{
				//destroy();
				LevelTree.ResetLevel();
			}
			if (e.target == saveButton.button)
			{
				//check for errors
				
				if (LevelTree.ContainsTreasure() && LevelTree.ContainsPlatforms())
				{
					XMLSaver.writeLevelData();
					MochiEvents.trackEvent('Custom Level Saved');
				}

				if(!LevelTree.ContainsTreasure())
				{
					MessageFactory.CreateMessage("Your Level Must Have Treasure!", 25);
				}
				
				if(!LevelTree.ContainsPlatforms())
				{
					MessageFactory.CreateMessage("You must use platforms or everything falls in the water!", 25, 90);
				}
			}
			
			if (e.target == exitButton.button)
			{
				destroy();				
			}
			
			if (e.target == loadButton.button)
			{
				GameController.HandleEvent("LoadCustomLevel");
				MochiEvents.trackEvent('Custom Level Loaded');
			}
		}
		
		public static function destroy(exitToMenu:Boolean = true):void
		{			
			exitButton.button.removeEventListener(MouseEvent.CLICK, handleClick);
			saveButton.button.removeEventListener(MouseEvent.CLICK, handleClick);		
			resetButton.button.removeEventListener(MouseEvent.CLICK, handleClick);	
			loadButton.button.removeEventListener(MouseEvent.CLICK, handleClick);				
			
			
			background.destroy();
			LevelTree.destroy();
			ToolBox.destroy();
			lineTool.destroy();
			nailTool.destroy();
			deleteTool.destroy();
			objectTool.destroy();
			Grid.destroy();			
			controller.destroy();
			exitButton.destroy();			
			saveButton.destroy();		
			loadButton.destroy();
			resetButton.destroy();
			SnapPoint.destroy();
			
			resetButton = null;
			saveButton = null;
			exitButton = null;
			lineTool = null;
			controller = null;
			grid = null;
			nailTool = null;
			levelTree = null;
			toolBox = null;
			
			Mouse.show();		
			
			if(exitToMenu)
			GameController.HandleEvent("LoadMenuFromEditor");
		}		
	}

}