package com.game.objects 
{
	import com.physics.blocks.Platform2D;
	import com.core.GameLevel;
	import com.game.GameObject;
	import com.game.blocks.platforms.*;
	import com.game.Water;
	import flash.display.MovieClip;
	import com.game.blocks.crates.*;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * This holds all the platforms in a single place. I like to do this because I want to perform a 
	 * drop shadow on them all to fake depth. 
	 */
	public class PlatformFactory
	{
		private static var platforms:Array;
		private static var dropShadows:Sprite;
		
		public function PlatformFactory() 
		{
			super();
			platforms = new Array();
		}
		
		public static function GetPlatforms():Array
		{
			return platforms;
		}
		
		public static function AddPlatform(p:Platform2D):void
		{
			platforms.push(p);
		}		
		
		//add shadows to everything
		public static function AddShadow():void
		{			
			dropShadows = new Sprite();
			
			//add all the drop shadows
			for  each(var p:Platform2D in platforms)
			{	
				var shadow:Sprite = new Sprite();
				
				//compile all the shadows into a single sprite
				shadow.graphics.beginFill(0x000000);
				shadow.graphics.drawRect(p.GetSkin().x , Water.waterLine, p.GetSkin().height, 14);
			
				//create the shadow
				shadow.graphics.endFill();
				dropShadows.addChild(shadow);
			}			
					
			Main.m_sprite.addChild(dropShadows);
			
			//set the alphas
			dropShadows.alpha = .45;
			
			//flur filter for the drop shadows
			var myBlur:BlurFilter = new BlurFilter();
			myBlur.quality = 3;
			myBlur.blurX = 10;
			myBlur.blurY = 10;
			dropShadows.filters = [myBlur];
		}		
	}
}