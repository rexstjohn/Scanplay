package com.game.ui 
{
	
	import com.core.GameController;
	import com.core.ObjectPool;
	import com.game.blocks.crates.PowderKeg;
	import com.game.fx.Smoke;
	import com.game.ship.PirateShip;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import com.menu.text.TextFactory;
	import com.core.factory.MessageFactory;
	import com.core.GameLevel;
	import com.menu.text.TextFactory;
	import com.core.factory.AssetFactory;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import com.menu.factory.MenuFactory;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * Counts how many shots the user has left
	 */
	public class ShotCounter 
	{
		private static var shots:Array;
		private static var parNotified:Boolean;
		private static var shotsLeft:TextField;
		public static var deathTimerStarted:Boolean;
		
		public function ShotCounter() 
		{
			super();
			parNotified = false;
			deathTimerStarted = false;
			shotsLeft = TextFactory.CreateTextField("");
			Main.m_stage.addChild(shotsLeft);
			shotsLeft.x = 10;
			shotsLeft.y = 10;
			
			shots = new Array();
			var count:int = GameLevel.par;			
			for (var g:int = 0; g < count; g++)
			{
				var s:Sprite = ObjectPool.GetObjectAs("Cannonball");
				shots.push(s);
				s.scaleX = s.scaleY = .35;
				s.x = (g * s.width + 28) + shotsLeft.textWidth;
				s.y = 28;				
				AssetFactory.AddShadow(s);
				Main.m_stage.addChild(s);
			}
			
			AssetFactory.AddTightShadow(shotsLeft);
			shots[shots.length - 1].alpha = .5;
			shotsLeft.visible = false;
		}
		
		public static function SetPosition(p:Point):void
		{
			shotsLeft.x = p.x;
			shotsLeft.y = p.y;
			
			for each(var s:Sprite in shots)
			{
				s.y = shotsLeft.y + (s.height / 2) + 5 ;
				s.x = (shots.indexOf(s) * s.width + 28) - (shotsLeft.textWidth / 2);
			}
		}
		
		public static function Show():void
		{
			for each(var g:Sprite in shots)
			{
				g.visible = true;
			}
			
			shotsLeft.visible = true;
		}		
		
		public static function Hide():void
		{
			for each(var g:Sprite in shots)
			{
				g.visible = false;
			}			
			shotsLeft.visible = false;
		}
		
		public static function RemoveShot():void
		{				
			if (shots.length > 1)
			{
				if (shots.length >= 1)
				{
					Main.m_stage.removeChild(shots[shots.length - 1]);					
					ObjectPool.ReturnObject(shots[shots.length - 1]);
					shots.splice(shots.length - 1, 1);
					shots[shots.length - 1].alpha = .3;
				}
				
				//inform the user they are over par
				if (GameLevel.shotsFired > (GameLevel.par))
				{
					if (!parNotified)
					{
						parNotified = true;
					}
				}
			}
			else
			{
				//handle a lost level, give them four seconds and then they lose
				if (!deathTimerStarted && (GameLevel.objectives.length > 0))
				{
					deathTimerStarted = true;
					LevelUI.HideUI();
					MessageFactory.CreateMessage("Yer Outta Shots!", 40,90);
					shots[0].alpha = 0;
					
					PirateShip.shootingLocked = true;
					var t:Timer = new Timer(1000);
					t.addEventListener(TimerEvent.TIMER, tick);
					t.start();
					var c:int = 3;
					var curLev:int = GameLevel.levelID;
					
					function tick(e:TimerEvent):void
					{
						///if(!GameLevel.summaryShowing)
						//MessageFactory.CreateMessage("Game Over in..." + c, 40, -30 + ( -40 * c));
						
						c--;
						
						if (c == 0)
						{
							t.stop();
							t.removeEventListener(TimerEvent.TIMER, tick);	
							
							if(GameLevel.levelID == curLev)
							GameLevel.HandleLevelOver();			
						}
					}
				}
			}
		}
		
		public static function destroy():void
		{
			for each(var s:Sprite in shots)
			{
				s.visible = false;
				ObjectPool.ReturnObject(s);
			}
			shotsLeft.visible = false;
			shotsLeft = null;
		}
	}
}