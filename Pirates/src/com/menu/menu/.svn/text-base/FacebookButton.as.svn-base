package com.menu.menu 
{
	import com.core.GameController;
	import com.menu.menu.MenuObject;
	import flash.display.Sprite;
	import com.core.factory.AssetFactory;
	import com.menu.factory.MenuFactory;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import mochi.as3.*;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class FacebookButton extends Button
	{
		public var streamButton:Sprite;
		
		public function FacebookButton(p:Point) 
		{
			super(p, "", "Stream", "PostToStream", "FacebookButton");
			button.height = 50;
			button.width = 50;
			button.x = p.x;
			button.y = p.y;
		}
		
		protected override function handleClick(e:MouseEvent):void
		{	
            MochiSocial.requestFan();
		}
	}
}