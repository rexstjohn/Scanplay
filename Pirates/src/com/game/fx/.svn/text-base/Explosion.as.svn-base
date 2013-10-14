package com.game.fx 
{
	import com.core.ObjectPool;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.core.factory.AssetFactory;
	import com.core.util.Utilities;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Explosion
	{
		private var isDead:Boolean;
		
		public function Explosion(key:String, x:Number, y:Number) 
		{
			var shatters:Array = new Array();
			isDead = false;
			var s:Sprite;
			var a:Number;
			
			for (var g:int = 0; g < 3; g++)
			{
				
				 s = ObjectPool.GetObjectAs(key);
				 a = Utilities.GetRandomNumberInARange(360, 0);
				s.scaleX = .1;
				s.scaleY = .1
				s.x = x;
				s.y = y;
				s.mouseEnabled = false;
				var obj:Object = new Object();
				obj["angle"] = a;
				obj["block"] = s;
				obj["force"] = Utilities.GetRandomNumberInARange(50, 30);
				Main.m_sprite.addChild(s);
				shatters.push(obj);				
			}
			
			var t:Timer = new Timer(500);
			var c:int = 0;
			var i:Object;
			var k:Object;
			t.addEventListener(TimerEvent.TIMER, handleTimer);
			Main.m_sprite.addEventListener(Event.ENTER_FRAME, animateShatter);
			
			function handleTimer(e:TimerEvent):void
			{
				//destroy the objects in question after 2 seconds
				if (c == 4)
				{
					isDead = true;
					t.stop();
					Main.m_sprite.removeEventListener(Event.ENTER_FRAME, animateShatter);
					t.removeEventListener(TimerEvent.TIMER, handleTimer);
					t = null;
					
					for each(i in shatters)
					{			
						i.block.visible = false;
						i = null;
					}	
				}				
				c++;
			}
			
			function animateShatter(e:Event):void
			{
				if (!isDead)
				{
					for each(i in shatters)
					{
						 i["block"].x += Math.cos(i["angle"]) * i["force"];
						 i["block"].y += Math.sin(i["angle"]) * i["force"];
						 i["block"].rotation += 10;
					}	
				}
				else
				{
					Main.m_sprite.removeEventListener(Event.ENTER_FRAME, animateShatter);
					
					for each(k in shatters)
					{
						k.block.visible = false;
						ObjectPool.ReturnObject(k.block);
						k = null;
					}
				}
			}
		}
		
		
	}

}