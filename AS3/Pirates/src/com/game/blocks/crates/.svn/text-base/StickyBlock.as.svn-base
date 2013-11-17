package com.game.blocks.crates
{
	import com.game.fx.Smoke;
	import com.physics.blocks.Block2D;
	import com.physics.blocks.PhysicsObject;
	import com.game.fx.Explosion;
	import com.game.ship.weapon.Weapon;
	import flash.geom.Point;
	import com.core.factory.SoundFactory;
	import com.core.factory.AssetFactory;
	import com.physics.GameWorld;
	import com.game.GameObject;
	import com.physics.controllers.StickyController;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * cannonballs stick to this block and won't budge, spraying splatters everywhere.
	 */
	public class StickyBlock extends Block2D
	{
		
		public function StickyBlock(_p:Point) 
		{
			super(_p, "StickyBlock", 0, "Splatter", false,500);
			SetAsIndestructable();
			points = 0;
			
			body.GetFixtureList().SetRestitution(0);
			body.GetFixtureList().SetFriction(10);
			GameWorld.stickyController.AddStickyBlock(this);
		}
		
		public override function handleCollission(o:PhysicsObject, force:Number):void
		{
			if(!GameWorld.stickyController.HasBlock(o) && o is Weapon)
			{
				var explostion:Explosion = new Explosion(damagedState, skin.x, skin.y);
				var smoke:Smoke = new Smoke(o.GetPosition());
				o.GetSkin().visible = false;
				SoundFactory.PlaySound("Splat_1");				
				GameWorld.stickyController.AddStuckBlock(o);
				o.GetBody().GetFixtureList().SetRestitution(0);
				o.GetBody().GetFixtureList().SetFriction(10);
			}
		}		
	}
}