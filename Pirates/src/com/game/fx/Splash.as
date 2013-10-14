package com.game.fx
{
	import com.core.factory.AssetFactory;
	import com.core.GameLevel;
	import com.core.ObjectPool;
	import com.game.GameObject;
	import flash.events.Event;
	import com.core.util.Utilities;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Splash extends GameObject
	{
		private var drops:Array = new Array();
		private var dropCount:int = 3;
		private var maxSize:Number = 10;
		private var minSize:Number = 1;
		private var speed:int = 5;
		private var t:Timer;
		private var alphaCount:int = 0;
		
		public function Splash(_p:Point) 
		{
			super();
			var g:int;
			var s:Object;
			
			for ( g = 0; g < dropCount; g++)
			{
				s = new Object();
				s["sprite"] = ObjectPool.GetObjectAs("SmokeBall");
				Main.m_sprite.addChild(s["sprite"]);
				drops.push(s);
				s["sprite"].height = s["sprite"].width = Utilities.GetRandomNumberInARange(maxSize, minSize);
				s["angle"] = 0 * (180 / Math.PI);
				s["sprite"].x = _p.x  - 15 + Utilities.GetRandomNumberInARange(15,1);
				s["sprite"].y = _p.y  + Utilities.GetRandomNumberInARange(30, 1);
				s.sprite.mouseEnabled = false;
				if (Utilities.GetRandomNumberInARange(10, 1) > 5) { s["type"] = "drop";}
				else{s["type"] = "stat";}
			}
			
			Main.m_sprite.addEventListener(Event.ENTER_FRAME, fadeSplash);
		}
		
		private var s:Object;
		private var k:Object;
		
		public function fadeSplash(e:Event):void
		{
			alphaCount ++;
			for each(s in drops)
			{
				s.sprite.y -= speed;
				s.sprite.alpha -= .5 / 30;
					
				if (s.sprite.alpha < .1)
				{
					s.sprite.visible = false;		
				}
			}
			
			if (alphaCount >= 90)
			{
				Main.m_sprite.removeEventListener(Event.ENTER_FRAME, fadeSplash);
				
				for each(k in drops)
				ObjectPool.ReturnObject(k.sprite);
				
				drops = null;
			}
		}
		
	}

}