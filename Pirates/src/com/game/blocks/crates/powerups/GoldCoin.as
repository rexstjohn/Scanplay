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
	public class GoldCoin extends Block2D
	{		
		public function GoldCoin(_p:Point) 
		{
			super(_p, "Coin", 500, "Coin", false, 20);		
		
			//hide the coin if the player has collected it already
			if (UserData.GetCoinsCollected()[GameLevel.levelID - 1] == true)
			{
				skin.visible = false;
				body.SetActive(false);
			}
		}		
		
		public override function Damage(damage:Number):void
		{}
		
		public override function handleCollission(o:PhysicsObject, force:Number):void
		{			
			if (o is Weapon)
			{
				//unlock gold coin
				var e:Explosion = new Explosion("Coin", skin.x, skin.y);
				MessageFactory.CreateMessage("You Got A Gold Coin!", 40,50);	
			
				SoundFactory.PlaySound("TreasureOpen");
				//unlock the coin for this user so it won't show up anymore
				UserData.GetCoinsCollected()[GameLevel.levelID -1] = true;
				UserData.Flush();
				
				if (UserData.CoinCount() == 10)
				{
					PopUpFactory.CreateAchievementPop("Upgrade Unlocked", "Black Pirate");
				}
				if (UserData.CoinCount() == 21)
				{
					PopUpFactory.CreateAchievementPop("Upgrade Unlocked", "Black Pirateship");
				}
				if (UserData.CoinCount() == 40)
				{
					PopUpFactory.CreateAchievementPop("Upgrade Unlocked", "Level Editor");
				}
				if (UserData.CoinCount() == 50)
				{
					PopUpFactory.CreateAchievementPop("Upgrade Unlocked", "Mega Ship");
				}
				Destroy();
			}
		}
	}
}