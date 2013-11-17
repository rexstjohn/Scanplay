package com.game.blocks.enemies 
{
	import com.physics.blocks.Block2D;
	import com.game.fx.Smoke;
	import com.game.ship.weapon.CannonBall;
	import com.physics.blocks.VariableShapedBlock2D;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import com.core.GameLevel;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class EnemyCannonPirate extends VariableShapedBlock2D
	{
		private var cannonMC:Sprite;
		private var angle:Number;
		private var globalPos:Point;
		
		private var time:Timer;
		
		public function EnemyCannonPirate(_p:Point):void
		{
			super(_p, "EnemyCannonPirate",130,150, 300, "Coin", false, 130);
			SetAsIndestructable();
			
		//	time = new Timer(4000);
		//	time.addEventListener(TimerEvent.TIMER, attackShip);
			//time.start();
			
			cannonMC = Sprite(Sprite(skin).getChildByName("Cannon"));
			Main.m_sprite.addEventListener(Event.ENTER_FRAME, update);

		}
		
		private function update(e:Event):void
		{
			/*
			skin.x += 30;
			skin.y += 10;
			var dx:Number = skin.x - GameLevel.GetObjectByType("PirateShip").GetSkin().x;
			var dy:Number= skin.y - GameLevel.GetObjectByType("PirateShip").GetSkin().y;
			angle = -Math.atan2(dy, dx) * (180 / Math.PI) ;
			cannonMC.getChildByName("Barrel").rotation = -angle;
			
			if (health <= 0)
			{
				time.stop();
				Main.m_sprite.removeEventListener(Event.ENTER_FRAME, update);
				time.removeEventListener(TimerEvent.TIMER, attackShip);
				MovieClip(skin).gotoAndStop(2);
			}
			
			globalPos = new Point(skin.x, skin.y);	
			globalPos.x -= skin.width;*/
		}	
		
		private function attackShip(e:TimerEvent):void
		{			
			var cb:CannonBall = new CannonBall(globalPos, -angle, -40); 
			var smoke:Smoke = new Smoke(globalPos);
		}
		
	}

}