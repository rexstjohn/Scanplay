package com.game.blocks.enemies 
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import com.core.factory.AssetFactory;
	import com.core.GameLevel;
	import com.game.fx.Explosion;
	import com.game.ship.Hull;
	import com.game.ship.Mast;
	import com.game.Water;
	import com.physics.blocks.Block2D;
	import com.physics.blocks.PhysicsObject;
	import com.physics.blocks.VariableShapedBlock2D;
	import com.physics.GameWorld;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class EvilPirateShip extends PhysicsObject	{		
		private var hull:Hull;
		private var mast:Mast;
		
		public function EvilPirateShip(_p:Point) 
		{
			//super(_p, "EvilPirateShip", 200, 200, 100, "Coin", false, 230);
			health = 60;
			
			hull = new Hull(50, 20);
			mast = new Mast(20, 60);
		
			skin = AssetFactory.GetSprite("EvilPirateShip");
			skin.height = 250;
			skin.width = 275;
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.type = b2Body.b2_dynamicBody;			
			bodyDef.position.Set(_p.x / GameWorld.pixels_per_meter,( _p.y + 50) / GameWorld.pixels_per_meter);
			body = GameWorld.m_world.CreateBody(bodyDef);
			
			//add the objects
			body = GameWorld.m_world.CreateBody(bodyDef);
			body.CreateFixture2(hull.polyShape, 1);		
			body.CreateFixture2(mast.polyShape, 1);		
			
			Main.m_sprite.addChild(skin);
			Water.AddFloatingBody(body);
		}	
		
		public override function Damage(damage:Number):void
		{
			health -= damage;
			
			if (health <= 0 )
			{
				GameLevel.CompleteObjective("PirateKilled");
				var e:Explosion = new Explosion("Coin", skin.x, skin.y);				
				Destroy();
			}
		}
		
		protected override function Update(e:Event):void
		{
			skin.x = ( body.GetPosition().x * GameWorld.pixels_per_meter);
			skin.y = ( body.GetPosition().y * GameWorld.pixels_per_meter ) - 125;
			skin.rotation =  body.GetAngle() * ( 180 / Math.PI);	
			
			if (skin.mouseEnabled)
			skin.mouseEnabled = false;
		}	
	}
}