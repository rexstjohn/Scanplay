package com.game.ui 
{
	import com.core.factory.AssetFactory;
	import com.core.GameLevel;
	import com.game.ship.PirateShip;
	import com.menu.menu.Button;
	import com.menu.text.TextFactory;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * A popup user for achievements
	 */
	public class AchievementPop
	{
		protected var title:TextField;
		protected var icon:Sprite;
		protected var message:TextField;
		protected var backing:Sprite;
		protected var closeButton:Button;
		
		public function AchievementPop(_iconName:String, _title:String, _message:String, _size:int = 40) 
		{
			icon = AssetFactory.GetSprite(_iconName);
			title = TextFactory.CreateTextField(_title, 34, true, false, 0x900202);
			message = TextFactory.CreateTextField(_message, _size, false, false, 0x900202);
			backing = AssetFactory.GetSprite("SpeechBubble");
			
			Main.m_stage.addChild(backing);
			Main.m_stage.addChild(message);
			Main.m_stage.addChild(title);
			Main.m_stage.addChild(icon);
			closeButton = new Button(new Point(400, 400), "Close", "", "");
			
			backing.x = 400;
			backing.y = 300;
			backing.scaleX = backing.scaleY = .6;
			message.x = 330;
			message.y = 300;
			title.x = 275;
			title.y = 230;
			icon.scaleX = icon.scaleY = .5;
			icon.x = 285;
			icon.y = 320;
			
			//reset the ship cannon
			if (GameLevel.isStarted() && PirateShip)
			{
				PirateShip.cannonReady = true;
				PirateShip.shootingLocked = false;
				PirateShip.power = PirateShip.minPower;
				PirateShip.clickState = "idle";
				PirateShip.guide.wipeGuide();
			}
			
			closeButton.GetButton().addEventListener(MouseEvent.CLICK, destroy);
		}
		
		public function destroy(e:* = null):void
		{
			closeButton.GetButton().removeEventListener(MouseEvent.CLICK, destroy);
			closeButton.destroy();
			
			backing.visible = false;
			message.visible = false;
			title.visible = false;
			icon.visible = false;
			
			closeButton = null;
			title = null;
			icon = null;
			message = null;
			closeButton = null;
			backing = null;
			
		}
		
	}

}