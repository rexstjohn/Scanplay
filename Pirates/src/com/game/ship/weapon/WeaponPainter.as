package com.game.ship.weapon 
{
	import Box2D.Dynamics.b2Body;
	import com.physics.GameWorld;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * Little object for making pain trails
	 */
	public class WeaponPainter
	{		
		protected var paintTime:Number = 3000;
		protected  var isPainting:Boolean = true; //leave a paint trail on the track of the ball
		protected  var paintInterval:int = 3;
		protected  var paintTrail:Array;
		protected var body:b2Body;
		protected var skin:Sprite;
		protected var count:int = 0;
		//remove the paint from the stage and destroy the body...
		private var paintClip:Sprite;
		private var isDestroyed:Boolean;
		
		public function WeaponPainter(b:b2Body, s:Sprite) 
		{
			paintTrail = new Array();
			paintClip = new Sprite();
			isDestroyed = false;
			paintClip.mouseEnabled = false;
			body = b;
			skin = s;
			Main.m_sprite.addChild(paintClip);
			Main.m_sprite.addEventListener(Event.ENTER_FRAME, Update);
		}
		
		private function Update(e:Event):void
		{			
			if(isPainting)
			Paint();
		}
		
		//paint the ball's trail
		protected function Paint():void
		{
			count++;
			
			if ((count % paintInterval) == 0)
			{
				var circle:Sprite = new Sprite( ); 
				circle.graphics.beginFill( 0xff9933 , 1 );
				circle.graphics.drawCircle(0, 0, 5);
				circle.x = body.GetPosition().x * GameWorld.pixels_per_meter;                                 
				circle.y = body.GetPosition().y * GameWorld.pixels_per_meter; 
				paintTrail.push(circle);
				circle.mouseEnabled = false;	
				paintClip.addChild(circle);
				
				if (!isDestroyed)
				{
					if (Main.m_sprite.getChildIndex(skin) < Main.m_sprite.getChildIndex(paintClip))
					Main.m_sprite.setChildIndex(skin, Main.m_sprite.getChildIndex(paintClip));
				}
			}			
		}
		
		
		public function Destroy():void
		{
			if (!isDestroyed)
			{
				Main.m_sprite.removeEventListener(Event.ENTER_FRAME, Update);	
				paintClip.visible = false;
				isDestroyed = true;				
				isPainting = false;		
				paintTrail = null;
			}
		}
		
		public function StopPaint():void
		{
			isPainting = false;
		}
		
		public function EnablePaint():void
		{
			isPainting = true;			
		}
		
		
	}

}