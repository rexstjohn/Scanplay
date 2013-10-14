package com.physics.blocks 
{
	import com.core.GameLevel;
	import com.core.ObjectPool;
	import com.game.fx.Explosion;
	import com.game.ship.weapon.Weapon;
	import com.physics.GameWorld;
	import flash.display.Sprite;
	import com.core.factory.AssetFactory;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class StaticPlatform2D extends Platform2D
	{		
		//decorations
		protected var c1:Sprite; //end cap 
		protected var c2:Sprite; //end cap
		protected var nail:Sprite;
		
		public function StaticPlatform2D(_p:Point, _p2:Point, _key:String, _points:int = 50, _damagedState:String = "undefined" , _health:Number = 10) 
		{			
			super(_p, _p2, _key, _damagedState, true, health);
			
			//create a nail
			nail = ObjectPool.GetObjectAs("Nail");	
			c1 =   ObjectPool.GetObjectAs("PlatformCorner");
			c2 =    ObjectPool.GetObjectAs("PlatformCorner");
			
			nail.x = (skin.x);
			nail.y = (skin.y);			
			c1.x = _p.x; c1.y = _p.y;
			c2.x = _p2.x; c2.y = _p2.y;
			c2.scaleX = c1.scaleX = c2.scaleY = c1.scaleY = .1;	
			
			Main.m_sprite.addChild(nail);
			Main.m_sprite.addChild(c2);
			Main.m_sprite.addChild(c1);
		}
		
		public override function handleCollission(o:PhysicsObject, force:Number):void
		{
			if (o is Weapon)
			{
				Damage(Weapon(o).GetDamage()  * force); 
			}	
		}	
		
		protected override function Update(e:Event):void
		{
			skin.x = nail.x = ( body.GetPosition().x * GameWorld.pixels_per_meter);
			skin.y = nail.y = ( body.GetPosition().y * GameWorld.pixels_per_meter );
			
			skin.rotation =  (body.GetAngle() * ( 180 / Math.PI)) + 90;
		}	
		public override function Destroy(_noScore:Boolean  =false):void
		{			
			isDead = true;			
			Main.m_sprite.removeEventListener(Event.ENTER_FRAME, Update);
			body.SetActive(false);
			
			ObjectPool.ReturnObject(skin);
			ObjectPool.ReturnObject(nail);
			ObjectPool.ReturnObject(c1);
			ObjectPool.ReturnObject(c2);
			
			if (!_noScore)
			GameLevel.UpdateScore(points);
		}
	}
}