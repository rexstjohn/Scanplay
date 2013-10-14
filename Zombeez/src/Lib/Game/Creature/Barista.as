package Lib.Game.Creature 
{
	import flash.events.Event;
	import Lib.Game.Creature.Creature;
	import flash.display.*;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Barista extends Creature
	{
		public var HealthBar:MovieClip;
		public var Head:MovieClip;
		public var Body:MovieClip;
		
		public function Barista() 
		{
			super("Barista");
			health  = 130;
			startingHealth = health;
			speed = 5.5;
			damage = 25;
			killValue = 50;
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