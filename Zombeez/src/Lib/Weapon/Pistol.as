package Lib.Weapon 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Lib.Weapon.Weapon;
	import flash.geom.Point;
	import flash.display.*;
	import Lib.Projectile.PistolBullet;
	import com.scanplay.utils.getRandom;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class Pistol extends Weapon
	{
		public var Arm:MovieClip;
		public var Torso:MovieClip;
		
		public function Pistol() 
		{
			super();
			Name = "Pistol";
			weaponName = Name;			
			Arm.stop();
			Torso.stop();
			Arm.Origin.visible = false;
		}
		
		public function init():void
		{
			//set the arm to point straight ahead
			var p:Point = globalizeCoordinates(Arm.x, Arm.y);
			
			var dy:Number = 400 - p.y;
			var dx:Number = 400 - p.x;			
			var radAngle:Number = Math.atan2(dy, dx);
			
			// finds the angle in radians (flash works in radians not degrees)
			Arm.rotation = -int(radAngle * 360 / (Math.PI * 2));
			addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		public function onEnter(e:Event):void
		{
			switch(Arm.currentLabel)
			{
				case "DoneFiring":
					Arm.gotoAndStop(1);
					Torso.gotoAndStop(1);
					break;
			}
		}
		public override function aimWeapon(mouseX:int, mouseY:int):void
		{			
			var p:Point = globalizeCoordinates(Arm.x,Arm.y);
			
			var dy:Number = mouseY - p.y;
			var dx:Number = mouseX - p.x;			
			var radAngle:Number = Math.atan2(dy, dx);
			var angle:Number = -int(radAngle * 360 / (Math.PI * 2));
			
			if (angle < 40 && angle > -30)
			{				
				// finds the angle in radians (flash works in radians not degrees)
				Arm.rotation = angle;
			}
		}
		public function createBulletEffect(targetX:int, targetY:int):void
		{			
			// settings
			const PARTICLE_MULT:int = 8;
			const PARTICLE_MAX_SIZE:int =  5;
			const PARTICLE_SPEED:int = 80;

			var particle_qty:Number = Math.random() * (PARTICLE_MULT/2) + (PARTICLE_MULT/2);
			
			for(var i:int=0; i<particle_qty; i++)
			{
				var pSize:Number = Math.random() * (PARTICLE_MAX_SIZE-1) + 1;
				var pAlpha:Number = 1;
		 
				// draw the particle
				var p:Sprite = new Sprite();
				p.graphics.beginFill(0x000000);
				p.graphics.drawCircle(0,0,pSize);
		 
				// create a movieclip so we can add properties to it
				var particle:MovieClip = new MovieClip();
				particle.addChild(p);
				particle.x = targetX;
				particle.y = targetY;
				particle.alpha = pAlpha;
				particle.name = "particle";		 
				particle.type = "bulletmisssparticle";
				
				// choose a direction and speed to send the particle
				var pFast:int = Math.round(Math.random() * 0.75);
				particle.pathX = (Math.random() * PARTICLE_SPEED - PARTICLE_SPEED/2) + 
					pFast * (Math.random() * 10 - 5);
				particle.pathY = (Math.random() * PARTICLE_SPEED - PARTICLE_SPEED/2) + 
					pFast * (Math.random() * 10 - 5);
		 
				// this event gets triggered every frame
				particle.addEventListener(Event.ENTER_FRAME, particlePath);
				parent.addChild(particle);
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
				e.target.parent.removeChild(e.target);
			}
		}
		
		private function createBullet(tx:int, ty:int):void
		{
			var bullet:PistolBullet = new PistolBullet();
			
			//convert the weapon origin point to a global coordinate
			var pt:Point = new Point(Arm.Origin.x, Arm.Origin.y);
			pt = localToGlobal(pt);
			
			bullet.x = pt.x;
			bullet.y = pt.y;
			
			parent.parent.addChild(bullet);
			projectiles.push(bullet);
			
			var targetX:Number = tx;
			var targetY:Number = ty;
			var speed:Number = bullet.speed; //pixels per frame
			var inTransit:Boolean = true;
			
			//numbers we will need to calculate x and y speed ration
			var travelY:Number = (targetY - bullet.y);
			var travelX:Number = (targetX - bullet.x);
			
			var sinRatio:Number = travelY / travelX;
			
			bullet.rotation = -Arm.rotation;//set the bullet rotation to be the same as the arm's rotation

			stage.addEventListener(Event.ENTER_FRAME, update);

			function update(e:Event):void
			{				
				bullet.x += speed;
				bullet.y += (speed * sinRatio);
				
				if (bullet.x >= 1000)
				{
					if (stage)
					{
						stage.removeEventListener(Event.ENTER_FRAME, update);
						
						if (stage.contains(bullet))
						{
							stage.removeChild(bullet);
						}
						
						for (var g:* in projectiles)
						{
							if (projectiles[g] == bullet)
							{
								projectiles.splice(g, 1);
							}
						}
					}
				}
			}
		}
		
		public override function handleClicks(e:MouseEvent):void
		{
			if (Arm.currentLabel == "Ready")
			{
				Torso.gotoAndPlay("Fire");
				Arm.gotoAndPlay("Fire");
				createBulletEffect(e.stageX - 150, e.stageY - 400);
				createBullet(e.stageX, e.stageY);
				weaponItem.decreaseAmmo();
			}
		}
	}

}