package com.game.blocks.crates
{
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import com.game.fx.Explosion;
	import com.physics.blocks.Block2D;
	import com.game.ship.weapon.Weapon;
	import flash.events.TimerEvent;
	import com.core.util.Utilities;
	import com.core.factory.AssetFactory
	import flash.display.Sprite;
	import com.core.factory.SoundFactory;
	import flash.display.MovieClip;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import com.game.blocks.*;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class GlassBlock extends Block2D
	{		
		
		public function GlassBlock(p:Point) 
		{
			super(p, "GlassBlock", 100,"GlassBlockDamaged",false, 6);
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