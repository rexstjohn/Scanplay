package com.game.ui 
{
	
	import com.core.GameController;
	import com.menu.menu.BasicButton;
	import com.core.Camera;
	import com.menu.menu.Button;
	import com.menu.text.TextFactory;
	import flash.display.Sprite;
	import com.menu.text.TextFactory;
	import com.menu.factory.MenuFactory;
	import com.core.factory.AssetFactory;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.core.GameLevel;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class InGameMenu 
	{		
		private static var bg:Sprite;
		private static var items:Array;
		
		//some buttons
		private static var resetButton:Button;
		private static var resumeGame:Button;
		private static var backButton:Button;
		
		//the title
		private static var title:TextField;
		
		
		public function InGameMenu() 
		{
			super();
			
			items = new Array();
			
			//make a background sprite to cover everything
			bg = new Sprite();
			bg.graphics.beginFill(0x000000, .9);
			bg.graphics.drawRect(0, 0, 1000, 1000);
			bg.graphics.endFill();
			bg.mouseChildren = false;
			Main.m_stage.addChild(bg);
			
			LevelUI.HideUI();
			
			title = TextFactory.CreateTextField("Menu", 50, true, true);
			Main.m_stage.addChild(title);
			title.x = (Main.m_stage.stageWidth / 2) - (title.textWidth / 2);
			title.y = 100;
			
			
			backButton  = new Button(new Point(Main.m_stage.stageWidth / 2, 360), "Exit Game", String(GameLevel.levelID), "ExitFromGameToMenu");
			resetButton = new Button(new Point(Main.m_stage.stageWidth / 2, 280), "Reset Level", String(GameLevel.levelID), "ReloadLastLevel");	
			resumeGame = new Button(new Point(Main.m_stage.stageWidth / 2, 200),"Resume Game", "InGameMenu", "DestroyInGameMenu");		

			Camera.SetPanLocked(true);		
			if (GameLevel.gameType == "Custom")
			resetButton.hide();
		}
		
		public static function destroy():void
		{
			Camera.SetPanLocked(false);
			resetButton.destroy();
			backButton.destroy();
			resumeGame.destroy();
			bg.visible = false;
			title.visible = false;
		}		
	}
}