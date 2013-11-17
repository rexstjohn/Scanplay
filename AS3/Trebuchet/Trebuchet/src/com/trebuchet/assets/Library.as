package com.trebuchet.assets
{
	import assets.*;
	
	import flash.display.Sprite;
	import flash.utils.*;
	
	public class Library
	{
		public static const COUNTRY_BG:String="assets.country_bg";
		public static const WOOD_TEXTURE:String="assets.wood";
		
		public static function createAsset(_assetKey:String):Sprite
		{
			trace("fetching class: " + getQualifiedClassName(assets.country_bg));
			trace("fetching class: " + getQualifiedClassName(assets.wood));
			var assetClass:Class = getDefinitionByName(_assetKey) as Class;
			var data:Sprite = Sprite(new assetClass()) ;
			return data;
		}
	}
}