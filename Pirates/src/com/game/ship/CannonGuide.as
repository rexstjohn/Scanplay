package com.game.ship 
{
	import com.game.GameObject;
	import com.game.*;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class CannonGuide extends GameObject
	{
		public var path:Sprite;
		private var length:int = 8;
		public var angle:Number;
		private var dots:Array = new Array();
		
		public function CannonGuide() 
		{
			super();
			path = new Sprite();
			
			for (var g:int = 0; g < length; g++)
			{				
				var circle:Shape = new Shape( ); 
				circle.graphics.beginFill( 0xff0000 , 1 );
				circle.graphics.drawCircle(0, 0, 5);
				circle.x = (g * (circle.width + 4));                                 
				circle.y = 0; 
				circle.alpha = 0;
				dots.push(circle);
				path.addChild(circle);
			}
			
			path.mouseEnabled = false;
			path.mouseChildren = false;
			
			Main.m_sprite.addChild(path);
		}
		
		//function for showing the guide based on how powerful the shot is
		public function Charge(p:Number, maxPow:Number):void
		{
			var alphaRatio:Number = (dots.length / (p / maxPow)) / 30;
			
			if (dots.length > 0)
			{
				for (var g:int = (dots.length - 1); g > 4; g--)
				{
					dots[g].alpha = (p / maxPow) * ( g / (dots.length - 1));
				}		
			}
		}
		
		public function UpdateRotation(a:Number):void
		{
			for (var g:int = 0; g < Main.m_sprite.numChildren; g++)
			{
				if (Main.m_sprite.getChildAt(g) != path)
				{
					if (Main.m_sprite.getChildIndex(Main.m_sprite.getChildAt(g)) > Main.m_sprite.getChildIndex(path))
					Main.m_sprite.setChildIndex(path, Main.m_sprite.getChildIndex(Main.m_sprite.getChildAt(g)));
				}
			}
			
			path.rotation = -a;
			angle = -path.rotation;
		}
		
		public function wipeGuide():void
		{
			for each (var g:Shape in dots)
			{
				g.alpha = 0;
				g.height = g.width = 10;
			}
		}
		public function SetPosition(_p:Point):void
		{
			path.x = _p.x;
			path.y = _p.y;
		}
		
	}

}