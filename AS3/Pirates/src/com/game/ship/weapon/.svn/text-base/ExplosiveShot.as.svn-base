package com.game.ship.weapon 
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.b2Vec2;
	import com.core.factory.SoundFactory;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import com.game.blocks.crates.TreasureBox;
	import com.physics.blocks.PhysicsObject;
	import com.game.fx.Smoke;
	import com.game.*;
	import com.physics.GameWorld;
	import flash.display.GraphicsTrianglePath;
	import flash.display.Sprite;
	import com.core.factory.AssetFactory;
	import flash.display.Shape;
	import com.core.util.Utilities;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.ContextMenuBuiltInItems;
	import com.core.*;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 * 
	 * Some notes on the cannonball...this is a very important class.
	 * 
	 * When a cannon ball comes to rest or is terminated, it resets the camera to the
	 * default target(usually the ship, almost always) and tells the ship to reset it's cannon to
	 * the default mode. 
	 */
	public class ExplosiveShot extends Weapon
	{
		private var exploded:Boolean = false;
		private var blastRadius:Number = 120;
		private var blastDamage:Number = 50;
		
		public function ExplosiveShot(_p:Point,angle:Number, force:Number) 
		{				
			super(_p, 7, force, angle, "ExplosiveCannonball", 10);				
		}
		
		public override function handleCollission(o:PhysicsObject, force:Number):void
		{
			if (!exploded)
			{
				exploded = true;
				painter.StopPaint();
				
				SoundFactory.PlaySound("PowderKeg");
				var smoke:Smoke = new Smoke(new Point(skin.x - 20, skin.y));
				body.SetAwake(false);
				HandleExplosion();
				
				//makes sure the camera sticks around after the explosion
				skin.visible = false;
			}
		}	
	
		//Damage anything in the blast radius
		private function HandleExplosion():void
		{	
			var explosion:Sprite = new Sprite();
			body.SetActive(false);
			shadow.visible = false;
			var dx:Number ;
			var dy:Number ;
			var angle:Number;
			var distance:Number;
			var bodyVec:b2Vec2 = new b2Vec2(0, 0);
			var forceVec:b2Vec2 = new b2Vec2(0, 0);
			
			for each (var i:PhysicsObject in GameLevel.GetObjects())
			{
				if (i != this)
				{
					explosion.graphics.beginFill(0xff0000, .2);
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
							i.GetBody().ApplyForce(forceVec,bodyVec);
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