package com.game.blocks.crates.powerups 
{
	import com.core.factory.MessageFactory;
	import com.core.factory.PopUpFactory;
	import com.core.factory.SoundFactory;
	import com.core.GameLevel;
	import com.core.user.UserData;
	import com.game.fx.Explosion;
	import com.game.ship.weapon.Weapon;
	import com.physics.blocks.Block2D;
	import com.physics.blocks.PhysicsObject;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class StarCrate extends Block2D
	{
		
		public function StarCrate(_p:Point) 
		{
			super(_p, "StarCrate", 500, "Coin", false, 20);		
			
			//hide the coin if the player has collected it already
			if (UserData.GetStarCratesCollected()[GameLevel.levelID - 1] == true)
			{
				skin.visible = false;
				body.SetActive(false);
			}
		}		
		
		public override function Damage(damage:Number):void
		{
			
		}
		
		public override function handleCollission(o:PhysicsObject, force:Number):void
		{			
			if (o is Weapon)
			{
				//unlock gold coin
				var e:Explosion = new Explosion("Coin", skin.x, skin.y);				
				SoundFactory.PlaySound("Crash", false, false, .5);
				MessageFactory.CreateMessage("You Got A Star Crate!", 40, 50);				
				
				if (UserData.StarCrateCount() == 40)
				{
					PopUpFactory.CreateAchievementPop("Upgrade Unlocked", "Secret Stash");
				}
				
				//unlock the coin for this user so it won't show up anymore
				UserData.GetStarCratesCollected()[GameLevel.levelID -1] = true;
				UserData.Flush();
				Destroy();
			}
		}
	}

}