package com.game.ship.weapon 
{
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.Controllers.b2GravityController;
	import com.core.*;
	import com.core.factory.*;
	import com.core.user.*;
	import com.core.util.Utilities;
	import com.game.*;
	import com.game.blocks.platforms.*;
	import com.game.fx.*;
	import com.game.ship.PirateShip;
	import com.physics.*;
	import com.physics.blocks.*;
	import com.physics.factory.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Weapon extends PhysicsObject
	{
		//state variables
		protected var state:String = "awake";
		private var created:Boolean = false;
		public var terminated:Boolean = false;
		
		//paint variables
		protected var count:int = 0; //count of paint dots
		protected var hasSplashed:Boolean;
		protected var shadow:Sprite;
		public var damage:Number;
		public var levelCreated:int;
		
		protected var painter:WeaponPainter;
		protected var doesPaint:Boolean;
		public var shotMultiplier:int = 1; //increases each time a block is broken
		
		public function Weapon(_p:Point, _damage:Number, _force:Number, _angle:Number, _skin:String, _radius:Number = 5, _paint:Boolean = true) 
		{						
			super(false);
			isStatic = false;	
			doesPaint = _paint;
			GameLevel.AddObject(this);	
			levelCreated = GameLevel.levelID;
			var cannonMouthAdjust:Point = _p;
			cannonMouthAdjust.x += 55 * Math.cos(_angle * (Math.PI/ 180));
			cannonMouthAdjust.y += 55 * Math.sin(_angle * (Math.PI / 180));			
			
			// set the shot size by the user data
			_radius = (UserData.GetStat("Shot Size") * (_radius / 6)) + _radius;
			
			var obj:Object = PhysicsFactory.CreatePhysicsObject(_p, _skin, "Circle2D",false,_radius);
			Main.m_sprite.addChild(obj["sprite"]);
			body = obj["body"];
			skin = obj["sprite"];	
			
			//set the damage
			hasSplashed = false;
			damage = _damage;
			
			//create the  shadow
			shadow = new Sprite();
			shadow.graphics.beginFill(0x000000);
			shadow.graphics.drawCircle(0, 0, 9);
			shadow.graphics.endFill();
			shadow.scaleY = .8;
			Main.m_sprite.addChild(shadow);					
			canRotate = false;			
			
			GameLevel.AddObject(this);
			var m:b2MassData = new b2MassData();
			m.mass = .04;
			body.SetMassData(m);
			
			//fuck with the aim as per the accuracy stat
			//_angle += Utilities.GetRandomNumberInARange(20, 0) * (1 - (UserData.GetStat("Accuracy") * 2)/ 10);
			//_angle -= Utilities.GetRandomNumberInARange(10, 0) * (1 - (UserData.GetStat("Accuracy") * 2)/ 10);
			
			//send the weapon flying		
			body.SetBullet(true);	
			body.ApplyForce(new b2Vec2(Math.cos((_angle) * (Math.PI/ 180) ) * _force, Math.sin((_angle) * (Math.PI/ 180)) * _force),body.GetPosition());
			created = true;
			
			painter = new WeaponPainter(body, skin);
			
			if (!doesPaint)
			painter.StopPaint();
			
			StartDeathTimer();		
			GameLevel.AddObject(this);
			body.GetFixtureList().SetFriction(.03);
			Main.m_sprite.addEventListener(Event.ENTER_FRAME, handleEnter);	
			Main.m_sprite.addEventListener(Event.ENTER_FRAME, Update);
			
			//set the bounce on the cannonball based on the userdata setting
			body.GetFixtureList().SetRestitution((UserData.GetStat("Bounce") / 8))
			
			//set the damage based on user data
			damage = (UserData.GetStat("Damage") * (damage / 6)) + (damage - 3);
			
			//set the size of the shot
					 
		}			
		
		//checks for skin on skin collissions with static platforms
		public function CheckStaticPlatformCollisions():void
		{
			var g:PhysicsObject;
			
			for each(g in GameLevel.GetObjects())
			{
				if (g.GetSkin() && (g != this) && (g is StaticPlatform2D))
				{
					if (g.GetSkin().hitTestObject(skin))
					{					
						PhysicsObject(g).handleCollission(this, 5);
					}
				}
			}
		}
		
		public function ClearGuide():void
		{
			painter.Destroy();
		}
			//create the body
		/* 
		 * There is a nasty error that occurs if you attempt to spawn a body between world timesteps.
		 * It seemes like createbody returns null whenever I create a body right on a collission step 
		 * so I have to force a step before attempting this creation or I get a null result.
		 * Shrapnel in particular has this issue.
		 */
		protected function CreateWhenReady(_p:Point, _damage:Number, _force:Number, _angle:Number, _skin:String, _radius:Number):void
		{			
			 var t:Timer = new Timer(1);
			 t.addEventListener(TimerEvent.TIMER, waitForUnlock);
			 t.start();
			 
			 function waitForUnlock(e:TimerEvent):void
			 {				 
				 if(!GameWorld.m_world.IsLocked())
				 {
					 t.stop();
					 t.removeEventListener(TimerEvent.TIMER, waitForUnlock);
					 
				 }
			 }
		}
		
		public function GetDamage():Number
		{
			return damage;
		}
		
		//destroy the cannonball after a few seconds
		//TODO: Add a "poof" animation
		private function StartDeathTimer():void
		{
			var t:Timer = new Timer(15000);
			t.addEventListener(TimerEvent.TIMER, tick);
			t.start();
			
			function tick(e:TimerEvent):void
			{	
				t.stop();
				t.removeEventListener(TimerEvent.TIMER, tick);			
				if (!isDead)
				{
					purge();
				}				
			}
		}
		
		public function handleEnter(e:Event):void
		{
			count++;
			
			//destroy the body if it falls off the screen
			if ((created && (body.GetPosition().y * GameWorld.pixels_per_meter) >= 700))
			{		
				painter.Destroy();
				
				if (!terminated)
				{
					terminated = true
				}
			}
			
			//check if the cannonball is hitting the water
			if (!hasSplashed)
			{
				//handle the cannonball shadow
				shadow.y = Water.waterLine;
				shadow.x = skin.x;
				shadow.alpha = (.08);
				
				if ((body.GetPosition().y * GameWorld.pixels_per_meter) > Water.waterLine)
				{
					hasSplashed  = true;
					Water.CreateSplash(body.GetPosition().x * GameWorld.pixels_per_meter);
					SoundFactory.PlaySound("Splash_1", false, false, .6);				
					skin.visible = false;// skin goes away when in the wayer
					shadow.visible = false;
					pauseThenPurge();
				}
				
				if ((body.GetPosition().x * GameWorld.pixels_per_meter) < -350)
				{var s:Smoke = new Smoke(GetPosition()); hasSplashed  = true; skin.visible = false; pauseThenPurge(); UserData.UnlockAchievement("LookOutBehindYou"); }
				
				if ((body.GetPosition().x * GameWorld.pixels_per_meter) > 2000)
				{var b:Smoke = new Smoke(GetPosition()); hasSplashed  = true; pauseThenPurge(); skin.visible = false; UserData.UnlockAchievement("Launched"); }
			
			}				
		}
		//pause the camera until the timer runs out, then purge
		private function pauseThenPurge():void
		{
			body.SetActive(false);
			
			if(GameLevel.started && CameraIsFollowingMe())
			{
				Camera.stopCamera = true;
				
				if(PirateShip.clickState != "idle" && PirateShip.clickState != "panningback" && (!GameLevel.levelOver) && (!GameLevel.shotsFired > GameLevel.par))
				MessageFactory.CreateMessage("Click Anywhere To Go Back", 40, 200, true, 800);
			}
			
			var endTimer:Timer  = new Timer(10000);
			endTimer.addEventListener(TimerEvent.TIMER, snapBack);
			endTimer.start();
			
			function snapBack(e:TimerEvent):void
			{						
				endTimer.removeEventListener(TimerEvent.TIMER, snapBack);
				endTimer.stop();
				
				//this is crazy, but it prevents us from causing objects to disappear after the level has advanced
				//object pools are fucking gay.
				if(GameLevel.levelID == levelCreated)
				purge();					
			}			
		}
		//destroy a body that leaves the bounds
		private function purge():void
		{
			body.SetActive(false);
			hasSplashed = true;
			//painter.Destroy();
			skin.visible = false;
			shadow.visible = false;
			
			if (CameraIsFollowingMe() && (PirateShip.clickState == "backtoship"))
			{
				Camera.FollowDefault();		
				GameController.HandleEvent("BackToShip");
			}			
		}
			
		private function CameraIsFollowingMe():Boolean
		{
			return (PirateShip.lastShot == this);// && Camera.GetOtherTarget() == this)
		}
		public override function handleCollission(o:PhysicsObject, f:Number):void
		{
			if (!isDead)
			{
				state = "damaged";
				painter.StopPaint();
				
				if (state != "asleep")
				{
					SoundFactory.PlaySound("WoodHit2", false,false, .3);
				}
				
			}
		}
		
		
		public function Sleep():void
		{state = "asleep";}
		
		public function GetState():String
		{return state;}
		
		
		/*
		 * Destroy the projectile next timestep that is available
		 * 
		 */
		public override function Destroy(_noScore:Boolean = false):void
		{
			isDead = true;
			Main.m_sprite.removeEventListener(Event.ENTER_FRAME, Update);
			Main.m_sprite.removeEventListener(Event.ENTER_FRAME, handleEnter);
			ObjectPool.ReturnObject(skin);
			painter.Destroy();
			body.SetActive(false);
			
		}		
	}
}