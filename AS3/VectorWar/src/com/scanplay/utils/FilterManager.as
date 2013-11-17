package com.scanplay.utils 
{
	import flash.geom.ColorTransform;
	import GameObjects.GameObject;
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class FilterManager
	{
		private var obj:GameObject;
		private var startFilters:ColorTransform;
		
		public function FilterManager(g:GameObject) 
		{
			obj = g;
			startFilters = obj.transform.colorTransform;
		}
		
	}

}