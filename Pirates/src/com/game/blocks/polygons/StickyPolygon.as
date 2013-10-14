package com.game.blocks.polygons
{
	import Box2D.Common.Math.b2Vec2;
	import com.physics.blocks.PhysicsObject;
	import com.physics.blocks.Polygon2D;
	import com.game.GameObject;
	import com.game.ship.weapon.Weapon;
	import flash.display.Sprite;
	import com.core.Camera;
	import flash.events.TimerEvent;
	import com.core.factory.SoundFactory;
	import flash.events.Event;
	import com.core.factory.AssetFactory;
	import com.core.util.Utilities;
	import flash.utils.Timer;
	import com.physics.GameWorld;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class StickyPolygon extends Polygon2D
	{
		public function StickyPolygon(_points:Array) 
		{
			super(_points, "StickyBlock");
			GameWorld.stickyController.AddStickyBlock(this);
			
			body.GetFixtureList().SetRestitution(0);
			body.GetFixtureList().SetFriction(10);
		}
		
		protected function Splatter():void
		{
			var shatters:Array = new Array();
			
			for each(var k:b2Vec2 in vertices)
			{
				for (var g:int = 0; g < 3; g++)
				{
					var s:Sprite = AssetFactory.GetSprite("Splatter");
					var a:Number = Utilities.GetRandomNumberInARange(360, 0);
					s.scaleX = .1;
					s.scaleY = .1
					s.x = skin.x;
					s.y = skin.y;
					var obj:Object = new Object();
					obj["angle"] = a;
					obj["block"] = s;
					obj["force"] = Utilities.GetRandomNumberInARange(50, 30);
					Main.m_sprite.addChild(s);
					shatters.push(obj);
				}
			}
			
			var t:Timer = new Timer(500);
			var c:int = 0;
			t.addEventListener(TimerEvent.TIMER, handleTimer);
			Main.m_sprite.addEventListener(Event.ENTER_FRAME, animateShatter);
			
			function handleTimer(e:TimerEvent):void
			{
				//destroy the objects in question after 2 seconds
				if (c == 4)
				{
					Main.m_sprite.removeEventListener(Event.ENTER_FRAME, animateShatter);
					t.stop();
					t.removeEventListener(TimerEvent.TIMER, handleTimer);
					
					for each(var i:Object in shatters)
					{
						if (Main.m_sprite.contains(i["block"]))
						{
							Main.m_sprite.removeChild(i["block"]);
						}
						
						i = null;
					}	
				}
				if (c == 7)
				{
					Camera.FollowDefault();
				}
				
				c++;
			}
			function animateShatter(e:Event):void
			{
				for each(var i:Object in shatters)
				{
				     i["block"].x += Math.cos(i["angle"]) * i["force"];
				     i["block"].y += Math.sin(i["angle"]) * i["force"];
					 i["block"].rotation += 10;
				}				
			}
		}
			
		public override function handleCollission(o:PhysicsObject, force:Number):void
		{
			if (o is Weapon)
			{
				if(!GameWorld.stickyController.HasBlock(o))
				{
					Splatter();					
					SoundFactory.PlaySound("Splat_1");		
					GameWorld.stickyController.AddStuckBlock(o);
					o.GetBody().GetFixtureList().SetRestitution(0);
					o.GetBody().GetFixtureList().SetFriction(10);
				}
			}
		}
	}

}