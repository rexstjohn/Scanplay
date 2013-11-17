package com.game.blocks.crates
{
	import com.game.fx.Explosion;
	import com.physics.blocks.Block2D;
	import com.game.blocks.*;
	import flash.events.Event;
	import com.game.ship.weapon.Weapon;
	import flash.utils.Timer;
	import com.core.util.Utilities;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.display.Sprite;
	import com.core.factory.AssetFactory;
	import com.core.factory.SoundFactory;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class WoodBlock extends Block2D
	{		
		public function WoodBlock(p:Point) 
		{
			super(p, "WoodBlock", 150,"WoodBlockDamaged",false, 20);		
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
				SoundFactory.PlaySound("Crash", false,false, .5);
				Destroy();
			}
		}		
	}
}