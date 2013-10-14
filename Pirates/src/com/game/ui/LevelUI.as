package com.game.ui
{
	import com.core.*;
	import com.core.factory.*;
	import com.core.factory.SoundFactory;
	import com.core.user.UserData;
	import com.game.*;
	import com.game.ship.PirateShip;
	import com.menu.factory.MenuFactory;
	import com.menu.menu.*;
	import com.game.blocks.crates.powerups.*;
	import com.menu.text.TextFactory;
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	import flash.text.TextField;
	import mochi.as3.MochiEvents;
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * Appears at the top on every level
	 */
	public class LevelUI extends GameObject
	{		
		//scores
		private static var chargeBar:PowerBar;
		private static var menuButton:BasicButton;
		private static var menu:InGameMenu;
		private static var powerup:WeaponIndicator;
		private static var shotCounter:ShotCounter ;
		public static var backToShip:Sprite;
		private static var soundToggle:Sprite;
		private static var premiumButton:Sprite;
		private static var zoomButton:Sprite;
		//public static var parText:TextField;
		
		//a textfield for tracking current game level
		private static var levelText:TextField;
		
		//level score
		private static var levelScore:TextField;
		
		//upgrade screen
		private static var upgrades:UpgradeScreen;
		
		//star crates
		private static var starCrate:Sprite;
		private static var starCrateCount:TextField;
		
		//coins
		private static var coinCrate:Sprite;
		private static var coinCount:TextField;
		
		public function LevelUI() 
		{
			super();	
			shotCounter = null;
			menuButton = new BasicButton(new Point(Main.m_sprite.stage.stageWidth /2, 40), "||", 40,70, Main.m_stage);
			chargeBar = new PowerBar();
			powerup = new WeaponIndicator(new Point(300, Main.m_stage.stageHeight - 35));
			
			//the zoom button
			zoomButton = AssetFactory.GetSprite("ZoomButtonOn");
			//Main.m_stage.addChild(zoomButton);
			zoomButton.x = Main.m_stage.stageWidth - 65;
			zoomButton.y = 55;
			zoomButton.buttonMode = true;
			zoomButton.mouseChildren = false;
			zoomButton.visible = false;
			zoomButton.scaleX = zoomButton.scaleY = .8;
			Camera.ZoomOut();
			
			//star crates and coin counts
			coinCount = TextFactory.CreateTextField(UserData.CoinCount() + " /20", 20);
			starCrateCount = TextFactory.CreateTextField(UserData.StarCrateCount() + " /20", 20);
			Main.m_stage.addChild(coinCount);
			Main.m_stage.addChild(starCrateCount);
			starCrate = AssetFactory.GetSprite("StarCrate");
			coinCrate = AssetFactory.GetSprite("Coin");
			Main.m_stage.addChild(coinCrate);
			Main.m_stage.addChild(starCrate);
			coinCount.x = 710; coinCount.y = 526;
			starCrateCount.x = 710; starCrateCount.y = 566;
			starCrate.x = 690; starCrate.y = 580;
			coinCrate.x = 690; coinCrate.y = 540;
			starCrate.height = coinCrate.height = starCrate.width = coinCrate.width = 25;
			
			//sound toggle
			soundToggle = AssetFactory.GetSprite("SoundToggleOn");			
			Main.m_stage.addChild(soundToggle);
			soundToggle.buttonMode = true;
			soundToggle.visible = false;
			AssetFactory.AddShadow(soundToggle);
			soundToggle.mouseChildren = false;
			soundToggle.x = 50;
			soundToggle.y = 40;
			soundToggle.scaleX = soundToggle.scaleY = .7;
			MovieClip(soundToggle).stop();
			
			
			if (Settings.mute)
			MovieClip(soundToggle).gotoAndStop("SoundToggleOff");
			else
			MovieClip(soundToggle).gotoAndStop("SoundToggleOn");					
			
			//back to ship button
			backToShip = AssetFactory.GetSprite("BackToShipButton");
			Main.m_stage.addChild(backToShip);
			backToShip.scaleX = backToShip.scaleY = .75;
			backToShip.name = "BackToShipButton";
			backToShip.mouseChildren = true;
			backToShip.mouseEnabled  = false;
			backToShip.x = (Main.m_sprite.stage.stageWidth) - 50;
			backToShip.y = (Main.m_sprite.stage.stageHeight) - 50;
			
			//the premium button
			premiumButton = AssetFactory.GetSprite("PremiumButton");
			Main.m_stage.addChild(premiumButton);
			premiumButton.x = Main.m_stage.stageWidth - 80;
			premiumButton.y = 40;
			premiumButton.buttonMode = true;
			premiumButton.mouseChildren = false;
			premiumButton.scaleX = premiumButton.scaleY = .7;
			
			/*
			 *  We have to adjust the  level counter to always be x/ the current episode
			 */ 
			var currentLevel:int = GameLevel.levelID;
			var levelcount:int    = 20;
			if (currentLevel > 20 && currentLevel < 41) currentLevel -= 20;
			if (currentLevel > 40)
			{
				currentLevel -= 40;
				levelcount -= 10;
			}
			
			levelText = TextFactory.CreateTextField("Level " + currentLevel + "/"+levelcount, 20);
			Main.m_stage.addChild(levelText);
			levelText.x = 15;
			levelText.y = 500;
			
			levelScore = TextFactory.CreateTextField("Score : " + 0, 20);
			Main.m_stage.addChild(levelScore);
			levelScore.x = 15;
			levelScore.y = 80;
			
			//hide it all on start
			HideUI();			
				
			Main.m_sprite.buttonMode = true;
			menuButton.button.addEventListener(MouseEvent.CLICK, handleClick);
			soundToggle.addEventListener(MouseEvent.CLICK, handleClick);
			zoomButton.addEventListener(MouseEvent.CLICK, handleClick);
			zoomButton.addEventListener(MouseEvent.MOUSE_OVER, handleOver);
			zoomButton.addEventListener(MouseEvent.MOUSE_OUT, handleOut);
			soundToggle.addEventListener(MouseEvent.MOUSE_OVER, handleOver);
			soundToggle.addEventListener(MouseEvent.MOUSE_OUT, handleOut);		
			premiumButton.addEventListener(MouseEvent.CLICK, handleClick);
			premiumButton.addEventListener(MouseEvent.MOUSE_OVER, handleOver);
			premiumButton.addEventListener(MouseEvent.MOUSE_OUT, handleOut);	
			
			//hide mochi
			Services.HideLoginWidget();
			
			//have to test this someplace
			if(GameLevel.levelID > 1)
			upgrades = new UpgradeScreen();			
		}
		
		public static function CreateShotCounter():void
		{			
			shotCounter = new ShotCounter();
			ShotCounter.SetPosition(new Point(30, Main.m_stage.stageHeight - 30));
			
			if (GameLevel.levelID > 2)
			{
				MessageFactory.CreateMessage("(Click Anywhere)", 40, 150);
				MessageFactory.CreateMessage("Press 'R' To Reset Level Anytime", 30, 190);
			}
			
			//parText = TextFactory.CreateTextField("Par: " + GameLevel.par, 20);
			//parText.x = 370;
			//parText.y = 65;
			//Main.m_stage.addChild(parText);
			//parText.visible = false;
			ShotCounter.Hide();
		}
		
		private static function handleOver(e:MouseEvent):void
		{	
			Sprite(e.target).filters = [new GlowFilter(0xFFFF00, .7, 3, 3, 2, 1)];
		}
		
		private static function handleOut(e:MouseEvent):void
		{		
			AssetFactory.AddShadow(Sprite(e.target));
		}
		
		public static function HideUI():void
		{			
			menuButton.hide();
			PowerBar.Hide();
			WeaponIndicator.Hide();
			
			if(shotCounter)
			{
				ShotCounter.Hide();
				//parText.visible = false;
			}
			
			levelText.visible = false;
			soundToggle.visible = false;
			zoomButton.visible = false;
			backToShip.visible = false;
			premiumButton.visible = false;
			levelScore.visible = false;
			
			starCrate.visible = false;
			starCrateCount.visible = false;
			coinCount.visible = false;
			coinCrate.visible = false;
		}
		
		public static function ShowUI():void
		{
			menuButton.show();
			soundToggle.visible = true;
			PowerBar.Show();		
			WeaponIndicator.Show();
			zoomButton.visible = true;
			levelText.visible = true;
			//backToShip.visible = true;
			premiumButton.visible = true;
			levelScore.visible = true;
			
			if (!shotCounter)
			CreateShotCounter();
			else
			ShotCounter.Show();
			
			//if (parText)
			//parText.visible  = true;
			
			starCrate.visible = true;
			starCrateCount.visible = true;
			coinCount.visible = true;
			coinCrate.visible = true;
		}
		
		public static function UpdateScore():void
		{
			if(Main.m_stage.contains(levelScore))
			{
				Main.m_stage.removeChild(levelScore);
				Main.m_stage.removeChild(starCrateCount);
				Main.m_stage.removeChild(coinCount);
			}
			
			levelScore = null;
			levelScore = TextFactory.CreateTextField("Score : " + GameLevel.Score, 20);
			
			//make sure we don't show the score if we are in a state where the UI is hidden			
			levelScore.x = 15;
			levelScore.y = 90;
			
			coinCount = TextFactory.CreateTextField(UserData.CoinCount() + " /20", 20);
			starCrateCount = TextFactory.CreateTextField(UserData.StarCrateCount() + " /20", 20);
			coinCount.x = 710; coinCount.y = 526;
			starCrateCount.x = 710; starCrateCount.y = 566;
			
			if(soundToggle.visible == true)
			{
				Main.m_stage.addChild(levelScore);
				Main.m_stage.addChild(starCrateCount);
				Main.m_stage.addChild(coinCount);
			}
			
			//hadle any achievements
			if (UserData.CoinCount() == 20)
			UserData.UnlockAchievement("20Coins");
			
			if (UserData.CoinCount() == 40)
			UserData.UnlockAchievement("40Coins");
			
			if (UserData.StarCrateCount() == 20)
			UserData.UnlockAchievement("20Stars");
			
			if (UserData.StarCrateCount() == 40)
			UserData.UnlockAchievement("40Stars");
			
			if (GameLevel.Score >= 90000)
			UserData.UnlockAchievement("HighScorer");
			
			
		}
		
		private static function handleClick(e:MouseEvent):void
		{			
			if (e.target == menuButton.button)
			{
				SoundFactory.PlaySound("ButtonClick", false, false, .4);
				menu = new InGameMenu();
				Camera.SetPanLocked(true);
			}
			
			//make sure we can't click the zoom until the ship has been unlocked from focus point
			if (e.target == soundToggle && PirateShip.clickState != "focuspoint")
			{
				SoundFactory.PlaySound("ButtonClick", false, false, .4);
				if (Settings.mute)
				{
					MovieClip(soundToggle).gotoAndStop("SoundToggleOn");
					Settings.Mute();
				
				}
				else
				{
					MovieClip(soundToggle).gotoAndStop("SoundToggleOff");
					Settings.Mute();			
				}			
			}
			
			if (e.target == zoomButton)
			{
				SoundFactory.PlaySound("ButtonClick", false, false, .4);
				if(!Camera.zoomed)
				{
					Camera.ZoomOut();
					zoomButton.alpha = .5;
				}
				else
				{
					Camera.ResetScale();
					zoomButton.alpha = 1;
				}
			}
			
			if (e.target == premiumButton)
			{
				MochiEvents.trackEvent('In-Game Store Button Clicked');
				SoundFactory.PlaySound("ButtonClick", false, false, .4);
				Services.ShowStore();
			}
		}
		
		
		public static function destroy():void
		{			
			menuButton.button.removeEventListener(MouseEvent.CLICK, handleClick);
			soundToggle.removeEventListener(MouseEvent.CLICK, handleClick);
			zoomButton.removeEventListener(MouseEvent.CLICK, handleClick);
			zoomButton.removeEventListener(MouseEvent.MOUSE_OVER, handleOver);
			zoomButton.removeEventListener(MouseEvent.MOUSE_OUT, handleOut);
			menuButton.button.removeEventListener(MouseEvent.MOUSE_OVER, handleOver);
			menuButton.button.removeEventListener(MouseEvent.MOUSE_OUT, handleOut);	
			soundToggle.removeEventListener(MouseEvent.MOUSE_OVER, handleOver);
			soundToggle.removeEventListener(MouseEvent.MOUSE_OUT, handleOut);	
			premiumButton.removeEventListener(MouseEvent.CLICK, handleClick);
			premiumButton.removeEventListener(MouseEvent.MOUSE_OVER, handleOver);
			premiumButton.removeEventListener(MouseEvent.MOUSE_OUT, handleOut);	
			Main.m_sprite.buttonMode = false;
			
			menuButton.destroy();
			PowerBar.destroy();
			WeaponIndicator.destroy();
			ShotCounter.destroy();
			ObjectPool.ReturnObject(soundToggle);
			ObjectPool.ReturnObject(zoomButton);
			ObjectPool.ReturnObject(backToShip);
			levelScore = null;
			
			//parText = null;			
			levelText = null;
			
			starCrate = null;
			coinCount = null;
			starCrateCount = null;
			coinCrate = null;
			
			//nullify
			//parText = null;
			premiumButton = null;
			menuButton = null;
			chargeBar = null;
			backToShip = null;
			zoomButton = null;
			soundToggle = null;
		}
	}

}