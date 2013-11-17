package com.game.fx 
{
	import com.core.factory.*;
	import com.core.GameLevel;
	import com.core.ObjectPool;
	import com.core.util.*;
	import com.game.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * a smoke cloud from the cannon
	 */
	public class Smoke extends GameObject
	{
		private var smoke:Array = new Array();
		private var count:int = 4;
		private var maxSize:Number = 25;
		private var minSize:Number = 10;
		private var speed:Number = 3;
		private var parent:Stage;
		private var alphaCount:int = 0;
		
		public function Smoke(_p:Point, _parent:Stage = null) 
		{
			super();
			
			if(_parent)
			parent = _parent;
			var g:int;
			var s:Sprite;
			
			for (g = 0; g < count; g++)
			{
				s = ObjectPool.GetObjectAs("SmokeBall");
				s.mouseEnabled = false;
				
				if(_parent)
				parent.addChild(s);				
				else
				{Main.m_sprite.addChild(s); }
				
				smoke.push(s);
				s.height = s.width = Utilities.GetRandomNumberInARange(maxSize,minSize);
				s.x      = _p.x + 50 + Utilities.GetRandomNumberInARange(30,1);
				s.y      = _p.y - 40 + Utilities.GetRandomNumberInARange(30,1);
			}
			
			Main.m_sprite.addEventListener(Event.ENTER_FRAME, fadeSmoke);
		}
		
		private var spr:Sprite;
		private var k:Sprite;
		
		public function fadeSmoke(e:Event):void
		{
			alphaCount ++;
			for each(spr in smoke)
			{
				spr.y -= speed;
				spr.alpha -= .5 / 30;
					
				if (spr.alpha < .1)
				spr.visible = false;		
			}
			
			if (alphaCount >= 90)
			{
				Main.m_sprite.addEventListener(Event.ENTER_FRAME, fadeSmoke);
				
				for each(k in smoke)
				{
					k.visible = false;
					ObjectPool.ReturnObject(k);
					k = null;
				}
				smoke = null;
			}
		}
		
	}

}