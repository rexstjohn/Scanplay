package com.game.blocks.crates
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.*;
	import com.game.fx.Explosion;
	import com.physics.blocks.Block2D;
	import com.game.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import com.core.util.Utilities;
	import com.game.*;
	import com.game.blocks.crates.*;
	import com.physics.GameWorld;
	import com.core.factory.AssetFactory;
	import flash.events.*;
	import com.core.factory.SoundFactory;
	import flash.geom.Point;
	import com.game.ship.weapon.CannonBall;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Grog extends Block2D
	{
		public function Grog(p:Point) 
		{
			super(p, "Grog", 200, "Grog", false, 6);
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
				var e:Explosion = new Explosion("WoodBlockDamaged", skin.x, skin.y);					
				SoundFactory.PlaySound("Crash", false,false, .5);
				Destroy();
			}
		}		
	}
}