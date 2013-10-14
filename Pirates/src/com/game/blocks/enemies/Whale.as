package com.game.blocks.enemies 
{
	import com.physics.blocks.Block2D;
	import com.physics.blocks.VariableShapedBlock2D;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Whale extends VariableShapedBlock2D
	{
		
		public function Whale(_p:Point):void
		{
			super(_p,"Whale",250,150, 100,"Coin");
			SetAsIndestructable();
		}		
	}
}