package com.game.blocks.crates.powerups 
{
	import Box2D.Common.Math.b2Vec2;
	import com.physics.blocks.Block2D;
	import com.physics.blocks.PhysicsObject;
	import com.core.factory.MessageFactory;
	import Box2D.Dynamics.*;
	import com.game.*;
	import com.game.fx.Explosion;
	import com.game.ship.weapon.Weapon;
	import com.game.ui.WeaponIndicator;
	import com.game.*;
	import com.physics.GameWorld;
	import flash.geom.Point;
	import com.game.blocks.*;
	import com.game.ship.weapon.CannonBall;
	import com.core.factory.AssetFactory;
	import flash.utils.Timer;
	import com.core.user.UserData;
	import flash.events.*;
	import com.core.util.Utilities;
	import flash.display.Sprite;
	import com.core.factory.SoundFactory;
	import com.game.ship.PirateShip;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class RubberShotCrate extends Block2D
	{
		
		public function RubberShotCrate(_p:Point) 
		{
			super(_p,"RubberShotCrate", 300, "WoodenBlock",false,5);	
		}
		
		
		public override function handleCollission(o:PhysicsObject, force:Number):void
		{
			if (o is Weapon)
			{
				var e:Explosion = new Explosion(damagedState,skin.x,skin.y);
				SoundFactory.PlaySound("Crash");
				MessageFactory.CreateMessage("Power Up Found: Rubber Shots");
				PirateShip.currentWeapon = "Cannonball_Rubber";
				WeaponIndicator.ActivatePowerup("Cannonball_Rubber");
				Destroy();
			}
		}	
	}

}