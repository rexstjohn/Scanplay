package com.game.blocks.enemies 
{
	import com.core.factory.AssetFactory;
	import com.game.fx.Explosion;
	import com.game.ship.weapon.Weapon;
	import com.game.Water;
	import com.physics.blocks.Block2D;
	import com.game.fx.Smoke;
	import com.game.ship.weapon.CannonBall;
	import com.physics.blocks.PhysicsObject;
	import com.physics.blocks.VariableShapedBlock2D;
	import com.physics.GameWorld;
	import flash.display.MovieClip;
	import com.core.factory.SoundFactory;
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
	public class EnemyPirate extends VariableShapedBlock2D
	{
		
		public function EnemyPirate(_p:Point):void
		{
			super(_p, "EnemyPirate", 100, 60, 300, "Coin", false, 30);
			//SetAsIndestructable();
		}		
		
		public override function handleCollission(o:PhysicsObject, force:Number):void
		{ 
			if (o is Weapon)
			{
				Damage(health);			
			}
			else
			Damage(force);
		}
		
		public override function Damage(damage:Number):void
		{
			if (!isDead)
			{
				health -= damage;
				
				if (health <= 0 )
				handleDeath();
			}
		}
		
		private function handleDeath():void
		{
			GameLevel.CompleteObjective("PirateKilled");
			SoundFactory.PlaySound("TreasureOpen");
			SoundFactory.PlaySound("Yarg");
			var s:Smoke = new Smoke(GetPosition());
			//var e:Explosion = new Explosion(damagedState, skin.x, skin.y);				
			Destroy();			
		}
		
		protected override function Update(e:Event):void
		{
			skin.x = ( body.GetPosition().x * GameWorld.pixels_per_meter) - 10;
			skin.y = ( body.GetPosition().y * GameWorld.pixels_per_meter ) - 11;
			
			if (canRotate)
			skin.rotation =  body.GetAngle() * ( 180 / Math.PI);	
			
			if (skin.mouseEnabled)
			skin.mouseEnabled = false;
			
			if(skin.y > (Water.waterLine - 60))
			handleDeath();
		}		
		
	}
}