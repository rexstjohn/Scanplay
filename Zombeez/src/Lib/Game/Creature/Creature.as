package Lib.Game.Creature 
{
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import Lib.GameObject;
	import flash.display.*;
	
	/**
	 * ...
	 * @author Rex
	 */
	public class Creature extends GameObject
	{
		public var creatureName:String;
		public var speed:int;
		public var health:int;
		public var damage:int;
		public var creatureState:String;
		public var projectiles:Array;
		public var healthBarInitialWidth:int;
		public var startingHealth:int;
		public var killValue:int; //how many coins this zombie drops when they die
				
		public function Creature(n:String) 
		{
			super("Creature");
			creatureName = n;			
		}
		
		public function init():void
		{			
			this.x = 900;
			this.y = 400;
			
			creatureState = "Alive";
			projectiles = new Array();
			
			//if we don't turn this on, the aiming gets fucked up
			mouseEnabled = false;
			mouseChildren = false;
			addEventListener(Event.ENTER_FRAME, onEnter);
		}
		public function onEnter(e:Event):void
		{				
			//if we are dead (At the last frame),stop, turn invisible
			if (currentLabel == "Destroy")
			{			
				stop();	
				creatureState = "Destroyed";
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
		}
		
		public function flashAndDie():void
		{
			if (currentLabel == "Walk")
			{
				creatureState = "Dead";
				die();
			}
		}
		
		public function die():void
		{
			gotoAndPlay("Die");
		}
		
		public function damageCreature(dmg:int):void
		{
			trace("damaged");
			doCreatureDamageAnimation(); // make a blood spray
			health -= dmg;	
		}
		
			// explosion function
		public function doCreatureDamageAnimation():void
		{
			flashRed(); // make the zombie flash red
			this.x += 15; //make the creature jump back
			
			// settings
			const PARTICLE_MULT:int = 12;
			const PARTICLE_MAX_SIZE:int =  22;
			const PARTICLE_SPEED:int = 80;

			var particle_qty:Number = Math.random() * (PARTICLE_MULT/2) + (PARTICLE_MULT/2);
			
			for(var i:int=0; i<particle_qty; i++)
			{
				var pSize:Number = Math.random() * (PARTICLE_MAX_SIZE-1) + 1;
				var pAlpha:Number = 1;
		 
				// draw the particle
				var p:Sprite = new Sprite();
				p.graphics.beginFill(0xFF0000);
				p.graphics.drawCircle(0,0,pSize);
		 
				// create a movieclip so we can add properties to it
				var particle:MovieClip = new MovieClip();
				particle.addChild(p);
				particle.x = this.x;
				particle.y = this.y - 25;
				particle.alpha = pAlpha;
				particle.name = "particle";
				particle.type = "bloodsplatter";
		 
				// choose a direction and speed to send the particle
				var pFast:int = Math.round(Math.random() * 0.75);
				particle.pathX = (Math.random() * PARTICLE_SPEED - PARTICLE_SPEED/2) + 
					pFast * (Math.random() * 10 - 5);
				particle.pathY = (Math.random() * PARTICLE_SPEED - PARTICLE_SPEED/2) + 
					pFast * (Math.random() * 10 - 5);
		 
				// this event gets triggered every frame
				particle.addEventListener(Event.ENTER_FRAME, particlePath);
				
				if (parent)
				{
					parent.addChild(particle);
				}
			}
		}
		// moves the particle
		private function particlePath(e:Event):void
		{
			e.target.x += e.target.pathX;
			e.target.y += e.target.pathY;
			e.target.alpha -= 0.4;
		 
			// removes the particle from stage when its alpha reaches zero
			if(e.target.alpha <= 0)
			{
				e.target.removeEventListener("enterFrame", particlePath);
				
				if (e.target.parent)
				{
					e.target.parent.removeChild(e.target);
				}
			}
		}
	}
}