package com.core 
{
	import com.core.factory.AssetFactory;
	import com.physics.blocks.PhysicsObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Transform;
	import flash.net.LocalConnection;
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * I found ongoing issues with returning objects directly to the objet pol
	 * after use in the level. I kept pulling out objects before they were finished
	 * being cleaned. Therefore, I created something called the garbage pool.
	 * 
	 * Objects that are checked out are first returned to the garbage pool,
	 * where they get cleaned several times to make sure. 
	 * 
	 * At the end of a level, the "clean pool" method is called, all the garbage ppol
	 * objects are cleaned again and added to the object pool again.
	 * 
	 * Sometimes, we wind up spawning huge numbers of particles. I want to keep a cap of 30
	 * objects for most levels, so we splice everything out over that amount and emplty
	 * the garbage pool.
	 */
	public class ObjectPool
	{
		private static var physicsObjects:Array;
		private static var garbagePool:Array; //where we store recently dumped objects
		private static var defaultTransform:Transform;
		
		public function ObjectPool(c:int) 
		{
			physicsObjects = new Array();
			garbagePool = new Array();
			
			for (var g:int = 0; g < c; g++)
			physicsObjects.push(AssetFactory.GetBlocks());
			
			defaultTransform = Sprite(physicsObjects[0]).transform;
		}
		
		public static function GetObject():Sprite
		{
			if (physicsObjects.length == 0)
			physicsObjects.push(AssetFactory.GetBlocks());
			
			var obj:Sprite = physicsObjects.shift();
			return obj;
		}
		
		public static function GetObjectAs(s:String):Sprite
		{
			if (physicsObjects.length == 0)			
			{
				physicsObjects.push(AssetFactory.GetBlocks());
			}
			
			var phys:Sprite = physicsObjects.shift();
			phys.visible = true;
			phys.alpha = 1;
			MovieClip(phys).gotoAndStop(s);
			
			//I am finding ongoing issues with unclean objects leaving the pool.
			//To counter this, I am installing a double cleaning system
			phys.transform.matrix = defaultTransform.matrix;
			phys.rotation = 0;
			phys.scaleX = phys.scaleY = 1;
			phys.alpha = 1;
			
			return phys;
		}
		
		public static function CleanPool():void
		{			
			for each(var g:Sprite in physicsObjects)
			{
				g.rotation = 0;
				g.transform.matrix = defaultTransform.matrix;
				g.scaleX = g.scaleY = 1;
				MovieClip(g).gotoAndStop(1);
				g.alpha = 1;
				g.visible = true;
			}
			
			for each(var k:Sprite in garbagePool)
			{
				k.rotation = 0;
				k.transform.matrix = defaultTransform.matrix;
				k.scaleX = k.scaleY = 1;
				MovieClip(k).gotoAndStop(1);
				k.alpha = 1;
				k.visible = true;
			}
			
			while (garbagePool.length > 0)
			physicsObjects.push(garbagePool.shift());
			
			while(physicsObjects.length > 30)
			{
				physicsObjects[0] = null;
				physicsObjects.splice(0, 1);
			}
		}
		
		public static function ReturnObject(s:Sprite):void
		{
			s.rotation = 0;
			s.scaleX = s.scaleY = 1;
			s.transform.matrix = defaultTransform.matrix;
			s.alpha = 1;
			s.visible = false;
			MovieClip(s).gotoAndStop(1);
			garbagePool.push(s);
		}
		
		public static function RunGC():void
		{
			try 
			{
				new LocalConnection().connect('GARBAGE');
				new LocalConnection().connect('GARBAGE');
			} catch (e:*) {}
			// the GC will perf
		}
	}

}