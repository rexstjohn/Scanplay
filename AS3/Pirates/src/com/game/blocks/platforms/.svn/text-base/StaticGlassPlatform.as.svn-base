package com.game.blocks.platforms
{
	import com.core.factory.SoundFactory;
	import com.game.fx.Explosion;
	import com.physics.blocks.StaticPlatform2D;
	import flash.display.Sprite;
	import flash.geom.Point;
	import Box2D.Common.Math.b2Vec2;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.MovieClip;
	import com.core.factory.AssetFactory;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * a wooden platform with nails in it so it cant move
	 */
	public class StaticGlassPlatform extends StaticPlatform2D
	{
		public function StaticGlassPlatform(_p:Point, _p2:Point) 
		{			
			super(_p, _p2, "GlassPlatform", 150, "GlassPlatformDamaged", 10);
		}				
		
		public override function Damage(damage:Number):void
		{
			health -= damage;
			
			if (health <= (startingHealth / 2) && !isDamaged)
			{
				MovieClip(skin).gotoAndStop(damagedState);
				isDamaged = true;
			}
			
			if (health <= 0 )
			{			
				var e:Explosion = new Explosion(damagedState, skin.x, skin.y);				
				SoundFactory.PlaySound("ShatterGlass", false, false,.6);
				Destroy();
			}
		}
	}
}