package com.game
{
	import adobe.utils.CustomActions;
	import com.core.factory.AssetFactory;
	import adobe.utils.ProductManager;
	import Box2D.Collision.b2Bound;
	import Box2D.Dynamics.b2Body;
	import com.game.GameObject;
	import com.core.util.Utilities;
	import com.game.objects.ArcticBackground;
	import com.game.objects.Background;
	import com.game.objects.TropicalBackground;
	import com.physics.GameWorld;
	import com.core.GameLevel;
	import flash.display.Sprite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ...
	 */
	public class GameBackground extends GameObject
	{		
		public var background:Background;
		
		public function GameBackground( _type:String = "Tropical") 
		{
			super();			
			
			if(_type == "Tropical")
			background= new TropicalBackground();
			if (_type == "Arctic")
			background = new ArcticBackground ();			
		}
	
		public function Show():void
		{
			background.Show();
		}
		public function stop():void
		{
			background.Pause();
		}
		
		public function resume():void
		{
			background.Resume();
		}
		
		public function destroy():void
		{
			background.destroy();
			background = null;
		}
	}

}