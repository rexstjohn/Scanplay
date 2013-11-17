package com.menu.menu 
{
	import com.menu.menu.MenuObject;
	import flash.display.Sprite;
	import com.core.factory.AssetFactory
	import flash.geom.Point;
	
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class MenuGraphic extends MenuObject
	{
		public var graphic:Sprite;
		
		public function MenuGraphic(_p:Point, id:String) 
		{
			super();
			graphic = AssetFactory.GetSprite(id);
			Main.m_stage.addChild(graphic);
			
			graphic.x = _p.x;
			graphic.y = _p.y;
		}
		
		public function destroy():void
		{
			Main.m_stage.removeChild(graphic);
			graphic = null;
		}		
	}
}