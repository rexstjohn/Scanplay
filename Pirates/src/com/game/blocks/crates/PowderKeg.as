package com.game.blocks.crates
{
	import Box2D.Collision.b2TimeOfImpact;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	import com.core.util.Utilities;
	import com.physics.blocks.Block2D;
	import com.physics.blocks.PhysicsObject;
	import com.core.factory.SoundFactory;
	import com.core.*;
	import com.core.factory.*;
	import com.core.user.*;
	import com.game.*;
	import com.game.*;
	import com.game.blocks.crates.*;
	import com.game.fx.*;
	import com.game.ship.weapon.*;
	import com.physics.blocks.Platform2D;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.Timer;
	
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class PowderKeg extends Block2D
	{
		private var blastRadius:Number = 80;
		private var blastDamage:Number = 50;
		
		public function PowderKeg(_p:Point) 
		{
			super(_p, "PowderKeg", 300, "Cannonball",false,20);
		}
		
		/*
		 * 
		 * Creates a glass shattering effect when the object explodes
		 * 
		 */
		
		public override function handleCollission(o:PhysicsObject, force:Number):void
		{
			if (o is Weapon && (!isDead))
			{
				Damage(health);			
			}
		}
		
		public override function Damage(damage:Number):void
		{
			health -= damage;
			
			if (health <= 0 && !isDead)
			{
				var oldColor:ColorTransform = skin.transform.colorTransform;
				var redColor:ColorTransform = new ColorTransform(1,0,0,1,1);
				var count:int = 0;
				var blink:Boolean = false;
				skin.transform.colorTransform = redColor;
				
				isDead = true;
				var t:Timer = new Timer(100);
				t.addEventListener(TimerEvent.TIMER, onexplode);
				t.start();
				
				function onexplode(e:TimerEvent):void
				{
					if(blink)
					skin.transform.colorTransform = redColor;
					else
					skin.transform.colorTransform = oldColor;
					
					
					if (count == 6)
					{
						HandleExplosion();
						t.stop();
						t.removeEventListener(TimerEvent.TIMER, onexplode);
									
						var smoke:Smoke = new Smoke(new Point(skin.x - 20, skin.y));
						var exp:Explosion = new Explosion(damagedState, skin.x, skin.y);	
						Destroy();
					}
					
					count++;
					blink = !blink;
				}
			}
		}
		
		//Damage anything in the blast radius
		private function HandleExplosion():void
		{
			GameLevel.kegsExploded++;
			
			if (GameLevel.kegsExploded == 8)
			UserData.UnlockAchievement("Boomer");			
			
			var explosion:Sprite = new Sprite();
			SoundFactory.PlaySound("PowderKeg");
			var dx:Number ;
			var dy:Number ;
			var angle:Number;
			var distance:Number;
			var forceVec:b2Vec2 = new b2Vec2(0, 0);
			var bodyVec:b2Vec2  = new b2Vec2(0, 0);
			var i:PhysicsObject;
			
			for each (i in GameLevel.GetObjects())
			{
				if (i != this)
				{
					explosion.graphics.beginFill(0xff0000, 0);
					dx = i.GetPosition().x - skin.x;
					dy = i.GetPosition().y - skin.y;
					distance = Math.sqrt(dy * dy + dx * dx);
					angle = -Math.atan2(dy, dx);
					
					if (distance < blastRadius)
					{						
						explosion.graphics.drawCircle(skin.x, skin.y, distance);
						explosion.graphics.endFill();
						Main.m_sprite.addChild(explosion);
						
						if(i.GetSkin().hitTestObject(explosion))					
						{
							forceVec.x = Math.cos(angle) * 5;
							forceVec.y = Math.sin(angle) * 5;
							i.GetBody().ApplyForce(forceVec, bodyVec);
							i.Damage(blastDamage);
						
							if (i is TreasureBox)
							TreasureBox(i).Open();
						}
					}					
				}
			}
			
			if (Main.m_sprite.contains(explosion))
			{
				Main.m_sprite.removeChild(explosion);
				explosion = null;
			}
		}
	}
}