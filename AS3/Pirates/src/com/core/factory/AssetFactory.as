package com.core.factory
{
	import com.physics.blocks.PhysicsObject;
	import com.physics.GameWorld;
	import flash.display.Sprite;
	import flash.display.*;
	import flash.filters.DropShadowFilter;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.text.Font;
	import flash.utils.ByteArray;
	import flash.filters.BlurFilter;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class AssetFactory
	{
		
		//All The Graphics
		private static var GameAssets:Array = new Array();
			
		//tutorial scripts
		[Embed(source = 'assets/scripts/scripts.xml',
        mimeType="application/octet-stream")]
		private const _scripts:Class;
		
		/*
		 * 
		 * LEVEL EMBEDS
		 * 
		 */ 
		
		[Embed(source = 'assets/levels/level_1.xml',
        mimeType="application/octet-stream")]
		private const _level1:Class;
		
		[Embed(source='assets/levels/level_2.xml',
        mimeType="application/octet-stream")]
		private const _level2:Class;
		
		[Embed(source = 'assets/levels/level_3.xml',
        mimeType="application/octet-stream")]
		private const _level3:Class;
		
		[Embed(source = 'assets/levels/level_4.xml',
        mimeType="application/octet-stream")]
		private const _level4:Class;
		
		[Embed(source = 'assets/levels/level_5.xml',
        mimeType="application/octet-stream")]
		private const _level5:Class;
		
		[Embed(source = 'assets/levels/level_6.xml',
        mimeType="application/octet-stream")]
		private const _level6:Class;
		
		[Embed(source = 'assets/levels/level_7.xml',
        mimeType="application/octet-stream")]
		private const _level7:Class;
		
		[Embed(source = 'assets/levels/level_8.xml',
        mimeType="application/octet-stream")]
		private const _level8:Class;
		
		[Embed(source = 'assets/levels/level_9.xml',
        mimeType="application/octet-stream")]
		private const _level9:Class;
		
		[Embed(source = 'assets/levels/level_10.xml',
        mimeType="application/octet-stream")]
		private const _level10:Class;
		
		[Embed(source = 'assets/levels/level_11.xml',
        mimeType="application/octet-stream")]
		private const _level11:Class;
		
		[Embed(source = 'assets/levels/level_12.xml',
        mimeType="application/octet-stream")]
		private const _level12:Class;
		
		[Embed(source='assets/levels/level_13.xml',
        mimeType="application/octet-stream")]
		private const _level13:Class;
		
		[Embed(source='assets/levels/level_14.xml',
        mimeType="application/octet-stream")]
		private const _level14:Class;
		
		[Embed(source='assets/levels/level_15.xml',
        mimeType="application/octet-stream")]
		private const _level15:Class;				
		
		[Embed(source='assets/levels/level_16.xml',
        mimeType="application/octet-stream")]
		private const _level16:Class;
		
		[Embed(source='assets/levels/level_17.xml',
        mimeType="application/octet-stream")]
		private const _level17:Class;
		
		[Embed(source='assets/levels/level_18.xml',
        mimeType="application/octet-stream")]
		private const _level18:Class;
		
		[Embed(source='assets/levels/level_19.xml',
        mimeType="application/octet-stream")]
		private const _level19:Class;
		
		[Embed(source='assets/levels/level_20.xml',
        mimeType="application/octet-stream")]
		private const _level20:Class;		
		
		[Embed(source='assets/levels/level_21.xml',
        mimeType="application/octet-stream")]
		private const _level21:Class;
		
		[Embed(source='assets/levels/level_22.xml',
        mimeType="application/octet-stream")]
		private const _level22:Class;
		
		[Embed(source='assets/levels/level_23.xml',
        mimeType="application/octet-stream")]
		private const _level23:Class;
		
		[Embed(source='assets/levels/level_24.xml',
        mimeType="application/octet-stream")]
		private const _level24:Class;
		
		
		[Embed(source='assets/levels/level_25.xml',
        mimeType="application/octet-stream")]
		private const _level25:Class;
		
		[Embed(source='assets/levels/level_26.xml',
        mimeType="application/octet-stream")]
		private const _level26:Class;
		
		[Embed(source='assets/levels/level_27.xml',
        mimeType="application/octet-stream")]
		private const _level27:Class;
		
		[Embed(source='assets/levels/level_28.xml',
        mimeType="application/octet-stream")]
		private const _level28:Class;
		
		[Embed(source='assets/levels/level_29.xml',
        mimeType="application/octet-stream")]
		private const _level29:Class;
		
		[Embed(source='assets/levels/level_30.xml',
        mimeType="application/octet-stream")]
		private const _level30:Class;
		
		[Embed(source='assets/levels/level_31.xml',
        mimeType="application/octet-stream")]
		private const _level31:Class;
		
		[Embed(source='assets/levels/level_32.xml',
        mimeType="application/octet-stream")]
		private const _level32:Class;
		
		[Embed(source='assets/levels/level_33.xml',
        mimeType="application/octet-stream")]
		private const _level33:Class;
		
		[Embed(source='assets/levels/level_34.xml',
        mimeType="application/octet-stream")]
		private const _level34:Class;
		
		[Embed(source='assets/levels/level_35.xml',
        mimeType="application/octet-stream")]
		private const _level35:Class;
		
		[Embed(source='assets/levels/level_36.xml',
        mimeType="application/octet-stream")]
		private const _level36:Class;
		
		[Embed(source='assets/levels/level_37.xml',
        mimeType="application/octet-stream")]
		private const _level37:Class;
		
		[Embed(source='assets/levels/level_38.xml',
        mimeType="application/octet-stream")]
		private const _level38:Class;
		
		[Embed(source='assets/levels/level_39.xml',
        mimeType="application/octet-stream")]
		private const _level39:Class;
		
		[Embed(source='assets/levels/level_40.xml',
        mimeType="application/octet-stream")]
		private const _level40:Class
		
		[Embed(source='assets/levels/level_41.xml',
        mimeType="application/octet-stream")]
		private const _level41:Class;
		
		
		[Embed(source='assets/levels/level_42.xml',
        mimeType="application/octet-stream")]
		private const _level42:Class;
		
		
		[Embed(source='assets/levels/level_43.xml',
        mimeType="application/octet-stream")]
		private const _level43:Class;
		
		
		[Embed(source='assets/levels/level_44.xml',
        mimeType="application/octet-stream")]
		private const _level44:Class;
		
		
		[Embed(source='assets/levels/level_45.xml',
        mimeType="application/octet-stream")]
		private const _level45:Class;
		
		
		[Embed(source='assets/levels/level_46.xml',
        mimeType="application/octet-stream")]
		private const _level46:Class;
		
		[Embed(source='assets/levels/level_47.xml',
        mimeType="application/octet-stream")]
		private const _level47:Class;
		
		[Embed(source='assets/levels/level_48.xml',
        mimeType="application/octet-stream")]
		private const _level48:Class;
		
		[Embed(source='assets/levels/level_49.xml',
        mimeType="application/octet-stream")]
		private const _level49:Class;
		
		[Embed(source='assets/levels/level_50.xml',
        mimeType="application/octet-stream")]
		private const _level50:Class;
		/*
		 *  The library swf
		 * 
		 */ 
		
		[Embed(source = 'assets/library.swf', symbol = 'Library')]
       private static const _library:Class;
	   
	   
		/*
		 * FONT EMBEDS
		 * 
		 */ 

       [Embed(source="assets/fonts/treamd.ttf", fontFamily="TreasureMapFont")] 
       private var _piratefont:String;
	   
       [Embed(source="assets/fonts/HouseMvmtTT-Custom.ttf", fontFamily="HouseMomentTT")] 
       private var _piratefont2:String;

		public function AssetFactory() 
		{
			super();
		
			//tropical background
			AddAsset("Sprite", "Library", _library);			
			
			
			//add the levels
			AddAsset("XML", "Scripts", _scripts);
			AddAsset("XML", "Level_1", _level1);
			AddAsset("XML", "Level_2", _level2);
			AddAsset("XML", "Level_3", _level3);
			AddAsset("XML", "Level_4", _level4);
			AddAsset("XML", "Level_5", _level5);
			AddAsset("XML", "Level_6", _level6);
			AddAsset("XML", "Level_7", _level7);
			AddAsset("XML", "Level_8", _level8);
			AddAsset("XML", "Level_9", _level9);
			AddAsset("XML", "Level_10", _level10);
			AddAsset("XML", "Level_11", _level11);
			AddAsset("XML", "Level_12", _level12);
			AddAsset("XML", "Level_13", _level13);
			AddAsset("XML", "Level_14", _level14);
			AddAsset("XML", "Level_15", _level15);
			AddAsset("XML", "Level_16", _level16);
			AddAsset("XML", "Level_17", _level17);
			AddAsset("XML", "Level_18", _level18);
			AddAsset("XML", "Level_19", _level19);
			AddAsset("XML", "Level_20", _level20);
			AddAsset("XML", "Level_21", _level21);
			AddAsset("XML", "Level_22", _level22);
			AddAsset("XML", "Level_23", _level23);
			AddAsset("XML", "Level_24", _level24);
			AddAsset("XML", "Level_25", _level25);
			AddAsset("XML", "Level_26", _level26);
			AddAsset("XML", "Level_27", _level27);
			AddAsset("XML", "Level_28", _level28);
			AddAsset("XML", "Level_29", _level29);
			AddAsset("XML", "Level_30", _level30);
			AddAsset("XML", "Level_31", _level31);
			AddAsset("XML", "Level_32", _level32);
			AddAsset("XML", "Level_33", _level33);
			AddAsset("XML", "Level_34", _level34);
			AddAsset("XML", "Level_35", _level35);
			AddAsset("XML", "Level_36", _level36);
			AddAsset("XML", "Level_37", _level37);
			AddAsset("XML", "Level_38", _level38);
			AddAsset("XML", "Level_39", _level39);
			AddAsset("XML", "Level_40", _level40);
			
			//secret stash			
			AddAsset("XML", "Level_41", _level41);
			AddAsset("XML", "Level_42", _level42);
			AddAsset("XML", "Level_43", _level43);
			AddAsset("XML", "Level_44", _level44);
			AddAsset("XML", "Level_45", _level45);
			AddAsset("XML", "Level_46", _level46);
			AddAsset("XML", "Level_47", _level47);
			AddAsset("XML", "Level_48", _level48);
			AddAsset("XML", "Level_49", _level49);
			AddAsset("XML", "Level_50", _level50);
		}
		
		public static function GetFont(i:String = "Default" ):String
		{
			var f:String;
			
			switch(i)
			{
				case "Default":
					f = "TreasureMapFont"
					break;
				case "House":
					f = "HouseMomentTT";
					break;
			}
		
			return f;
		}
		
		private function AddAsset(type:String, key:String, mcClass:Class):void		
		{
			var newAsset:Object = new Object();
			var classDef:Class = mcClass;
			
			newAsset["type"] = type;
			newAsset["key"] = key;
			newAsset["class"] = classDef;
			
			GameAssets.push(newAsset);
		}
		
		public static function GetXML(key:String):XML
		{
			var mc:ByteArray = null;
			
			for each(var s:Object in GameAssets)
			{
				if (s["key"] == key)
				{
					if (s["type"] == "XML")
					{
						trace("XML fetched");
						//this generates a brand new copy of our class asset
						mc = new s["class"]();
					}
				}
			}			
			
			XML.ignoreWhitespace = true;
			var str:String = mc.readUTFBytes( mc.length );			
			
			return new XML( str );			
		}
		
		public static function GetSprite(key:String):Sprite
		{
			var mc:Sprite = Sprite(new _library());
			MovieClip(mc).gotoAndStop(key);		
			//mc.cacheAsBitmap = true;
			return mc;			
		}
		
		public static function GetBlocks():Sprite
		{
			var blocks:Sprite = Sprite(new _library());
			MovieClip(blocks).gotoAndStop(1);
			//blocks.cacheAsBitmap = true;
			return blocks;
		}
		
		
		//get  abitmap from the library
		public static function GetImage(key:String):Bitmap
		{
			var mc:Bitmap = null;
			
			for each(var s:Object in GameAssets)
			{
				if (s["key"] == key)
				{
					if (s["type"] == "Image")
					{
						//this generates a brand new copy of our class asset
						mc = new s["class"]();
					}
				}
			}				
			
			return mc;			
		}
		
		public static function ApplyBlur(s:Sprite):void
		{
			s.filters = [new BlurFilter(3,3)];
		}
		
		public static function DestroySprite(s:Sprite):void
		{
			
			MovieClip(s).stop();
			
			if (Main.m_sprite.contains(s))
			{Main.m_sprite.removeChild(s)}
			
			if (Main.m_stage.contains(s))
			{Main.m_stage.removeChild(s)}
			
			s = null;
		}
		
		public static function AddShadow(s:Sprite):void
		{			
			var my_shadow:DropShadowFilter = new DropShadowFilter();  
			my_shadow.color = 0x000000;  
			my_shadow.blurY = 0;  
			my_shadow.blurX = 0;  
			my_shadow.angle = 100;  
			my_shadow.alpha = .35;  
			my_shadow.distance = 5;  
			s.filters = [my_shadow];
		}
		
		public static function AddTightShadow(s:DisplayObject):void
		{
			
			var my_shadow:DropShadowFilter = new DropShadowFilter();  
			my_shadow.color = 0x000000;  
			my_shadow.blurY = 0;  
			my_shadow.blurX = 0;  
			my_shadow.angle = 100;  
			my_shadow.alpha = .35;  
			my_shadow.distance = 2.5;  
			s.filters = [my_shadow];
		}
				
		public static function AddInnerShadow(s:Sprite):void
		{			
			var my_shadow:DropShadowFilter = new DropShadowFilter();  
			my_shadow.color = 0x000000;  
			my_shadow.blurY = 4;  
			my_shadow.blurX = 4;  
			my_shadow.angle = 45;  
			my_shadow.alpha = .25;  
			my_shadow.distance = 12;  
			my_shadow.inner = true;
			s.filters = [my_shadow];
		}
		
	}

}