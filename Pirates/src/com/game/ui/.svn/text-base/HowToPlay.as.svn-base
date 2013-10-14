package com.game.ui 
{
	import com.core.GameController;
	import com.core.ObjectPool;
	import com.game.GameObject;
	import com.menu.menu.BasicButton;
	import flash.display.Sprite;
	import com.core.factory.AssetFactory;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.menu.factory.MenuFactory;
	import com.core.factory.LevelFactory;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * Pop up tutorial that appears when the player clicks level 1 and teaches
	 * them how to play. Upon destruction, loads level 1.
	 */
	
	import flash.display.MovieClip;
	
	public class HowToPlay extends GameObject
	{
		public var bg:Sprite;
		public var tutorial:Sprite;
		
		//some controls
		public var exitButton:BasicButton;
		
		public function HowToPlay() 
		{
			super();
			
			tutorial = ObjectPool.GetObjectAs("Tutorial");
			
			//make a background sprite to cover everything
			bg = new Sprite();
			bg.graphics.beginFill(0x000000, 1);
			bg.graphics.drawRect(0, 0, 1000, 1000);
			bg.graphics.endFill();
			
			Main.m_stage.addChild(bg);		
			Main.m_stage.addChild(tutorial);
			exitButton = new BasicButton(new Point(Main.m_stage.stageWidth / 2, 550), "Close");
			
			tutorial.x = (Main.m_stage.stageWidth / 2) - 100 ;
			tutorial.y = 250;
			
						
			exitButton.button.addEventListener(MouseEvent.CLICK, exit);		
		}
		
		private function exit(e:MouseEvent):void
		{
			destroy();
		}
		
		public function destroy():void
		{
			exitButton.destroy();
			ObjectPool.ReturnObject(tutorial);
			GameController.HandleEvent("LoadLevelFromMenu", 1)		
		}
		
	}

}