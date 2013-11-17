package com.physics.blocks 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import com.core.factory.AssetFactory;
	import com.core.GameLevel;
	import com.core.ObjectPool;
	import com.core.util.Utilities;
	import com.game.Water;
	import com.physics.GameWorld;
	import com.game.GameObject;
	import com.game.fx.Explosion;
	import com.game.ship.weapon.Weapon;
	import com.core.factory.SoundFactory;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class PhysicsObject extends GameObject
	{
		//skin and body of the objects
		protected var damagedState:String;
		protected var points:int;
		protected var body:b2Body;
		protected var health:Number;
		protected var startingHealth:Number;
		protected var skin:Sprite;
		
		//state variables
		public    var canBeNailed:Boolean;
		protected var isDead:Boolean;
		protected var isDestructable:Boolean;
		protected var isStatic:Boolean;
		protected var isExploding:Boolean;
		protected var canRotate:Boolean;
		public    var isFloating:Boolean;
		protected var isDamaged:Boolean;
		
		public function PhysicsObject(hotStart:Boolean = true, _health:Number = 10) 
		{			
			//set default values
			canBeNailed    = true;
			isDead         = false;
			isDestructable = true;
			isExploding    = true;
			isStatic       = false;
			points         = 100;
			isFloating     = true;		
			canRotate      = true;
			isDamaged      = false;
			startingHealth = health = 10;
			
			if(hotStart)
			Main.m_sprite.addEventListener(Event.ENTER_FRAME, Update, false,0,true);
		}
		
		protected function SetAsIndestructable():void
		{
			isExploding = false;
			isDestructable = false;
		}
		
		public function Damage(damage:Number):void
		{
			if (isDestructable)
			{
				health -= damage;
				
				if (health <= (startingHealth / 2) && !isDamaged)
				{
					MovieClip(skin).gotoAndStop(damagedState);
					isDamaged = true;
				}
				
				if (health <= 0 )
				{
					if (isExploding)				
					var e:Explosion = new Explosion(damagedState, skin.x, skin.y);				
					SoundFactory.PlaySound("Crash", false,false, .5);
				
					Destroy();
				}
			}
		}
		
		public function GetPosition():Point
		{
			return (new Point(skin.x, skin.y));
		}
		
		private var count:Number = 0;
		private var vec:b2Vec2 = new b2Vec2(0, 0);
		private var fVec:b2Vec2 = new b2Vec2(0, .007);
		
		protected function Update(e:Event):void
		{
			skin.x = ( body.GetPosition().x * GameWorld.pixels_per_meter);
			skin.y = ( body.GetPosition().y * GameWorld.pixels_per_meter );
			
			if (canRotate)
			skin.rotation =  body.GetAngle() * ( 180 / Math.PI);	
			
			if (skin.mouseEnabled)
			skin.mouseEnabled = false;
			
			
			count++;
			if (count > 30)
			count = 0;
			
			if (skin.y >= (Water.waterLine - 50) && (count == 30))
			{				
				if (Utilities.GetRandomNumberInARange(100, 1) > 50)
				fVec.y *= -1;
				
				body.ApplyImpulse(fVec, vec);
			}
		}		
		
		public function SetPosition(_p:Point):void
		{
			skin.x = _p.x;
			skin.y = _p.y;
			
			body.SetPosition(new b2Vec2(_p.x / GameWorld.pixels_per_meter, _p.y / GameWorld.pixels_per_meter));
		}
		
		public function GetBody():b2Body
		{return body; }
		
		public function handleCollission(o:PhysicsObject, force:Number):void
		{
			if (isDestructable && !isDead)
			{
				if (o is Weapon)
				Damage(Weapon(o).GetDamage()  * force); 
				else
				Damage(force);
			}
		}	
		
		public function GetSkin():Sprite
		{
			return skin;
		}
		
		public function GetPoints():int
		{
			return points;
		}
		
		public function IsAlive():Boolean
		{
			return !isDead;
		}
		/*
		 * Destroy the projectile next timestep that is available
		 * 
		 */
		public function Destroy(_noScore:Boolean = false):void
		{
			isDead = true;
			Main.m_sprite.removeEventListener(Event.ENTER_FRAME, Update);
					
			body.SetActive(false);
			ObjectPool.ReturnObject(skin);		
			
			//we need to do this because we don't want to award points when the game is auto destroying the level
			if(!_noScore)
			{
				GameLevel.UpdateScore(points);
			}
		}
	}
}