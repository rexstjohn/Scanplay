package com.game.blocks.crates.powerups 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.*;
	import com.physics.blocks.Block2D;
	import com.physics.blocks.PhysicsObject;
	import com.game.fx.Explosion;
	import com.game.ship.weapon.Weapon;
	import com.game.ui.WeaponIndicator;
	import com.game.*;
	import com.game.*;
	import com.physics.GameWorld;
	import com.core.user.UserData;
	import flash.geom.Point;
	import com.game.ship.weapon.CannonBall;
	import com.core.factory.AssetFactory;
	import flash.utils.Timer;
	import flash.events.*;
	import com.core.util.Utilities;
	import com.core.factory.SoundFactory;
	import com.core.factory.MessageFactory;
	import flash.display.Sprite;
	import com.game.ship.PirateShip;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class ExplosiveShotCrate extends Block2D
	{
		
		public function ExplosiveShotCrate(_p:Point) 
		{
			super(_p, "ExplosiveShotCrate",300,"WoodenBlock", false,5);
		}
				
		public override function handleCollission(o:PhysicsObject, force:Number):void
		{
			if (o is Weapon)
			{
				var e:Explosion = new Explosion(damagedState,skin.x,skin.y);
				SoundFactory.PlaySound("Crash");				
				MessageFactory.CreateMessage("Power Up Found: Exploding Shots");
				PirateShip.currentWeapon = "Cannonball_Explosive";
				WeaponIndicator.ActivatePowerup("Cannonball_Explosive");
				Destroy();
			}
		}
		
	}

}