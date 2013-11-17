package Lib.Game.Creature 
{
	import Lib.Game.Creature.Creature;
	import flash.events.*;
	import flash.display.*;
	import Lib.Projectile.Present;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class BadSanta extends Creature
	{		
		public var HealthBar:MovieClip;
		public var Head:MovieClip;
		public var Body:MovieClip;
		
		public function BadSanta() 
		{
			super("BadSanta");
			health  = 250;
			speed = 2;			
			damage = 25;
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
		
		public override function init():void
		{			
			this.x = 900;
			this.y = 400;
			
			creatureState = "Alive";
			projectiles = new Array();
			
			//if we don't turn this on, the aiming gets fucked up
			mouseEnabled = false;
			mouseChildren = false;
			addEventListener(Event.ENTER_FRAME, onEnter);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}
		
		public function onRemoved(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			removeEventListener(Event.ENTER_FRAME, onEnter);
			
			for (var k:* in projectiles)
			{
				if (parent.contains(projectiles[k]))
				{
					parent.removeChild(projectiles[k]);
					projectiles.splice(k, 1);
				}
			}
		}		
		
		public override function onEnter(e:Event):void
		{				
			//if we are dead (At the last frame),stop, turn invisible
			if (currentLabel == "Destroy")
			{				
				removeEventListener(Event.ENTER_FRAME, onEnter);
				creatureState = "Destroyed";
				
				for (var k:* in projectiles)
				{
					parent.removeChild(projectiles[k]);
					projectiles.splice(k, 1);
				}
				return;
			}		
								
			if ((currentLabel == "WalkDone") && (creatureState == "Alive"))
			{
				gotoAndPlay("Walk");
			}
			
			if ((this.health <= 0) && (creatureState == "Alive"))
			{			
				creatureState = "Dead";
				die();
			}				
			
			if (creatureState != "Dead")
			{				
				this.x -= speed;
			}
			
			if ((currentLabel == "ThrowPresent") && (creatureState != "Destroyed") && (parent))
			{
				if (currentLabel != "DoneThrowing")
				{
					var present:Present = new Present();
					present.x = this.x - 60;
					present.y = this.y;
					present.scaleX = .25;
					present.scaleY = .25;
					projectiles.push(present);
					
					if (parent)
					{
						parent.addChild(projectiles[projectiles.length - 1]);
					}
				}
			}
			
			//move presents			
			for (var g:int = 0; g < projectiles.length; g++)
			{
				projectiles[g].x -= 5;
				projectiles[g].rotation += 20;
			}
			
		}
	}

}