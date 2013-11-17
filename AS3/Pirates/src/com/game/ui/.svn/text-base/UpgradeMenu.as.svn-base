package com.game.ui 
{
	
	import com.core.factory.*;
	import com.core.user.*;
	import com.core.util.*;
	import com.game.fx.*;
	import com.menu.factory.*;
	import com.menu.menu.*;
	import com.menu.text.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class UpgradeMenu 
	{
		//buttons
		private var closeButton:BasicButton;
		private var items:Array;
		
		//overlay
		private var bg:Sprite;		
		
		//title
		private var title:TextField;
		private var subtext:TextField;
		
		//store items
		private var rubberShot:StoreItem;
		private var explosiveShot:StoreItem;
		private var tripleShot:StoreItem;
		
		private var levelID:int;
		
		public function UpgradeMenu(lid:int) 
		{
			super();
			items = new Array();
			levelID = lid;
			//make a background sprite to cover everything
			bg = new Sprite();
			bg.graphics.beginFill(0x000000, 1);
			bg.graphics.drawRect(0, 0, 1000, 1000);
			bg.graphics.endFill();
			Main.m_stage.addChild(bg);				
			
			title = TextFactory.CreateTextField("Get A Power-Up?", 50,true,true);
			subtext = TextFactory.CreateTextField("A weapon upgrade can help you improve your score!", 24);
			Main.m_stage.addChild(subtext);
			Main.m_stage.addChild(title);
			
			title.x = (Main.m_stage.stageWidth / 2) - (title.textWidth / 2);
			title.y = 50;
			subtext.x = (Main.m_stage.stageWidth / 2) - (subtext.textWidth / 2);
			subtext.y = 110;
			
			closeButton = new BasicButton(new Point((Main.m_sprite.stage.stageWidth / 2), 500),"Continue", 40, 120);
			
			rubberShot = new StoreItem(new Point(200, 250), "RubberShotCrate", 200, "Bounces", "Rubber Shot", "Cannonball_Rubber");
			explosiveShot = new StoreItem(new Point(400, 250), "ExplosiveShotCrate", 200, "Explodes", "Explosive Shot", "Cannonball_Explosive");
			tripleShot = new StoreItem(new Point(600, 250), "TripleShotCrate", 200, "Three For one", "Triple Shot", "Cannonball_Triple");
			
			closeButton.button.addEventListener(MouseEvent.CLICK, close);			
			
			items.push(rubberShot);
			items.push(explosiveShot);
			items.push(tripleShot);
			
			rubberShot.buyButton.button.addEventListener(MouseEvent.CLICK, handleBuy);
			tripleShot.buyButton.button.addEventListener(MouseEvent.CLICK, handleBuy);
			explosiveShot.buyButton.button.addEventListener(MouseEvent.CLICK, handleBuy);
		}		
		
		private function handleBuy(e:MouseEvent):void
		{
			switch(e.currentTarget)
			{
				case rubberShot.buyButton.button:
					makeSelection(rubberShot);
					MessageFactory.CreateMessage("Power Up Enabled: Rubber Shot",40,100);
					UserData.UnlockAchievement("BigSpender");
					break;
				case tripleShot.buyButton.button:
					makeSelection(tripleShot);
					MessageFactory.CreateMessage("Power Up Enabled: Triple Shot",40,100);
					UserData.UnlockAchievement("BigSpender");
					break;
				case explosiveShot.buyButton.button:
					makeSelection(explosiveShot);
					MessageFactory.CreateMessage("Power Up Enabled: Explosive Shot", 40, 100);
					UserData.UnlockAchievement("BigSpender");
					break;
			}
			
			function makeSelection(i:StoreItem):void
			{
				for each( var g:StoreItem in items)
				{
					if (i == g)
					{
						g.activate();
						
						for (var k:int = 0; k < 4; k++)
						{
							var s:Smoke = new Smoke(new Point(g.graphic.x - 40 + Utilities.GetRandomNumberInARange(50,0), g.graphic.y - 40+ Utilities.GetRandomNumberInARange(50,0)), Main.m_stage);
						}
					}
					else
					{
						g.deactivate();
					}
				}
			}
		}
		
		private function close(e:MouseEvent):void
		{
			destroy();
		}
		
		public function destroy():void
		{
			rubberShot.destroy();
			explosiveShot.destroy();
			tripleShot.destroy();
			closeButton.destroy();
			
			//load whatever the target level is
			MenuFactory.destroy(); //kills the stage
			LevelFactory.LoadLevel(levelID);
		}
		
	}

}