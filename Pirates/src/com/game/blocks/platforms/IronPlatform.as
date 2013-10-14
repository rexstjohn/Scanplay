package com.game.blocks.platforms
{
	import Box2D.Common.Math.b2Vec2;
	import com.physics.blocks.Platform2D;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.MovieClip;
	import com.core.factory.AssetFactory;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class IronPlatform extends Platform2D
	{
		
		public function IronPlatform(_p:Point, _p2:Point) 
		{
			super(_p, _p2, "IronPlatform", "undefined", false,500);	
			SetAsIndestructable();
			points = 0;
		}		
	}
}