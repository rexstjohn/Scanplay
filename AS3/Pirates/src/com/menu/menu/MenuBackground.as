package com.menu.menu
{
	import adobe.utils.CustomActions;
	import adobe.utils.ProductManager;
	import Box2D.Collision.b2Bound;
	import Box2D.Dynamics.b2Body;
	import com.game.GameObject;
	import com.core.factory.AssetFactory;
	import com.core.util.Utilities;
	import com.game.objects.TropicalBackground;
	import flash.events.Event;
	import flash.utils.*;
	import flash.display.Shape;
	import com.menu.menu.MenuObject;
	import com.physics.GameWorld;
	import flash.display.MovieClip;
	import com.core.GameLevel;
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ...
	 */
	public class MenuBackground extends MenuObject
	{			
		public var background:TropicalBackground;
		
		public function MenuBackground() 
		{
			background = new TropicalBackground();
		}
		
		public function Show():void
		{
			background.Show();
		}
		
		public function destroy():void
		{
			background.destroy();
			background = null;
		}	
	}
}