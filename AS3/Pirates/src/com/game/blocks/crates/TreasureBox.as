package com.game.blocks.crates
{
	import Box2D.Dynamics.*;
	import com.core.factory.AssetFactory;
	import com.physics.blocks.*;
	import com.core.*;
	import com.core.user.*;
	import com.game.*;
	import com.core.factory.SoundFactory;
	import com.game.fx.Explosion;
	import com.game.ship.weapon.*;
	import flash.display.*;
	import com.core.factory.SoundFactory;
	import flash.events.*;
	import flash.geom.*;
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * These are special "hard to find" treasures hidden in several levels.
	 */
	public class TreasureBox extends Block2D
	{
		private var chestMC:MovieClip;
		private var isOpen:Boolean;
		
		public function TreasureBox(_p:Point) 
		{
			super(_p, "TreasureChest", 500,"Coin", false);	
			SetAsIndestructable();
			isOpen = false;
			MovieClip(MovieClip(skin).getChildAt(0)).stop();
			chestMC = MovieClip(MovieClip(skin).getChildAt(0));
		}		
		
		public override function handleCollission(o:PhysicsObject, force:Number):void
		{
			if ((o is Weapon) && (!isDead) && !isOpen)
			Open();
		}		
		
		public function Open():void
		{			
			if (!isOpen)
			{
				isOpen = true;
				health = 0;
				isDead = true;
				UserData.AddGold(500);
				SoundFactory.PlaySound("TreasureOpen");
				GameLevel.CompleteObjective("TreasureFound");
					
				var e:Explosion = new Explosion("Coin", skin.x, skin.y);
				chestMC.play();
				GameLevel.UpdateScore(500);
				
				skin.addEventListener(Event.ENTER_FRAME, handleEnter);
				
				function handleEnter(e:Event):void
				{
					if (chestMC.currentFrame == chestMC.totalFrames)
					{
						skin.removeEventListener(Event.ENTER_FRAME, handleEnter);
						chestMC.stop();
					}
				}
			}
		}
	}

}