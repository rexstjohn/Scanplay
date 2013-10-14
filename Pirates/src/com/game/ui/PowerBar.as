package com.game.ui
{
	import com.game.GameObject;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import com.menu.text.TextFactory;
	import com.menu.factory.MenuFactory;
	import com.core.factory.AssetFactory;
	import com.game.ship.PirateShip;
	import flash.events.Event;
	import flash.text.TextField;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class PowerBar extends GameObject
	{
		public static var bar:Sprite;
		public static var lastShot:Number = 0;
		public static var lastShotLine:Sprite;
		public static var percent:Number;
		private static var text:TextField;
		private static var chargeBarMC:MovieClip;
		
		public function PowerBar() 
		{
			super();
			text                 = TextFactory.CreateTextField("Cannon Power");
			bar                  = AssetFactory.GetSprite("PowerBar");
			chargeBarMC          = MovieClip(MovieClip(bar).getChildAt(0));
			bar.scaleX           = bar.scaleY = .25;
			MovieClip(MovieClip(bar).getChildAt(0)).stop();
			
			lastShotLine = new Sprite();
			lastShotLine.graphics.lineStyle(2);
			lastShotLine.graphics.moveTo(0, 0);
			lastShotLine.graphics.lineTo(0, 25);
			
			bar.x = 50;
			bar.y = Main.m_stage.stageHeight - 50;
			
			Main.m_stage.addChild(bar);
			Main.m_stage.addChild(lastShotLine);
			Main.m_sprite.addEventListener(Event.ENTER_FRAME, handleEnter);
		}
		
		public static function Show():void
		{
			chargeBarMC.visible = true;
			lastShotLine.visible = false;
		} 
		
		public static function Hide():void
		{
			chargeBarMC.visible = false;
			lastShotLine.visible = false;
		}
		
		public static function SetPosition(x:Number, y:Number):void
		{
			bar.x = x;
			bar.y = y;
			lastShotLine.y = chargeBarMC.y - 6;
			lastShotLine.x = x - (chargeBarMC.width / 2) + lastShot;
		}
		
		public static function handleEnter(e:Event):void
		{
			percent = ((PirateShip.power - PirateShip.minPower) / (PirateShip.maxPower - PirateShip.minPower));
			chargeBarMC.gotoAndStop(Math.round(percent * chargeBarMC.totalFrames));
		}
		
		public static function SetFireLine():void
		{
			lastShot =  ((chargeBarMC.width) * percent);
			lastShot -= 8 + (8 * percent);
		}
		
		public static function destroy():void
		{
			Main.m_sprite.removeEventListener(Event.ENTER_FRAME, handleEnter);
			chargeBarMC = null;
			bar = null;
		}		
	}
}