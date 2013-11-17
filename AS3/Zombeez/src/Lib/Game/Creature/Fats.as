package Lib.Game.Creature 
{
	import Lib.Game.Creature.Creature;
	import flash.display.*;
	import flash.events.*;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class Fats extends Creature
	{
		
		public var HealthBar:MovieClip;
		public var Head:MovieClip;
		public var Body:MovieClip;
		
		public function Fats() 
		{
			super("Fats");
			health  = 800;
			speed = 1;
			damage = 200;
			killValue = 500;
			startingHealth = health;
			healthBarInitialWidth = HealthBar.width;
			Head.visible = false;
			Body.visible = false;
			HealthBar.addEventListener(Event.ENTER_FRAME, checkHealth);
		}
			
		public function checkHealth(e:Event):void
		{
			if (health <= 0)
			{
				HealthBar.width = 0;
				HealthBar.removeEventListener(Event.ENTER_FRAME, checkHealth);
			}
		}
		public override function damageCreature(dmg:int):void
		{
			doCreatureDamageAnimation();
			health -= dmg;		
			HealthBar.width = (healthBarInitialWidth * (health / startingHealth));
			sf.playSound("SplatterSound2");
		}
	}

}