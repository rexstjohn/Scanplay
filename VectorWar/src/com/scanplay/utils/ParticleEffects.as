package com.scanplay.utils 
{
	import flash.display.MovieClip;
	import Particles.Spark;
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class ParticleEffects
	{
		private var obj:MovieClip;
		private var particles:Array;
		
		public function ParticleEffects(o:MovieClip) 
		{
			obj = o;
			particles = new Array();
		}
		
		public function explode():void
		{
			var count:int = 50;
			
			
		}
		
		public function sparks():void
		{
			var count:int = 50;
			
			for (var g:int = 0; g < count; g++)
			{
				var p:Spark = new Spark();
				p.x = obj.x;
				p.y = obj.y;
				
			}
			
		}
		
		public function burst():void
		{
			var count:int = 50;
			
			
		}
		
	}

}