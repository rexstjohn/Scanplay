package com.menu.menu 
{
	import com.menu.menu.MenuObject;
	import flash.display.Sprite;
	import com.core.factory.AssetFactory;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Logo extends MenuObject
	{
		private var asset:Sprite;
		
		public function Logo() 
		{
			super();
			asset = AssetFactory.GetSprite("Logo");
			Main.m_sprite.addChild(asset);
			asset.x = Main.m_sprite.stage.stageWidth / 2;
			asset.y = 140;
			
			AssetFactory.AddShadow(asset);
		}
		
		public function destroy():void
		{
			asset = null;
		}		
	}
}