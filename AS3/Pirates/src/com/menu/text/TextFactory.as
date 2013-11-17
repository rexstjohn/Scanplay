package com.menu.text 
{
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import com.menu.text.TextFactory;
	import com.core.factory.AssetFactory;
	import flash.text.AntiAliasType;
	import flash.filters.GlowFilter;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class TextFactory
	{
       [Embed(source="fonts/treamd.ttf", fontFamily="TreasureMapFont")] 
       private static const  _treasureMapFont:String;
	   
       [Embed(source="fonts/HouseMvmtTT-Custom.ttf", fontFamily="HouseMomentTT")] 
       private static const _houseMomentFont:String;
			   
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
		
				
		public static function CreateTextField(s:String, sz:int = 26, shadow:Boolean = true, glow:Boolean = false, color:Number = 0xffffff):TextField
		{	
			var format:TextFormat = new TextFormat();
			format.size = sz;
			format.color = color;
			format.letterSpacing = 2.3;
			format.font = AssetFactory.GetFont("House");			
			
			var tf:TextField = new TextField();
			tf.text = s;			
			tf.embedFonts = true;
			tf.autoSize = TextFieldAutoSize.CENTER;
		    tf.antiAliasType = AntiAliasType.ADVANCED;
		    tf.setTextFormat( format);	
			tf.mouseEnabled = false;
			//AddFilters(tf, shadow, glow);
			
			return tf;
		}
		
		private static function AddFilters(txt:TextField, isShadow:Boolean, isGlow:Boolean):void
		{			
			//next, create the top of the platform
			var my_shadow:DropShadowFilter = new DropShadowFilter();  
			my_shadow.color = 0x000000;  
			my_shadow.blurY = 0;  
			my_shadow.blurX = 0;  
			my_shadow.angle = 90;  
			my_shadow.alpha = 1;  
			my_shadow.distance = 3.5;   
			
			var glow:GlowFilter = new GlowFilter( 0x0099CC, .9, 25, 25,1, 2, false, false);			
			var filtersArray:Array = new Array();  
			
			if (isGlow)
			filtersArray.push(glow);
			
			if(isShadow)
			filtersArray.push(my_shadow);
			
			txt.filters = filtersArray;
		}		
		
		public static function AddShadow(s:Sprite):void
		{			
			var my_shadow:DropShadowFilter = new DropShadowFilter();  
			my_shadow.color = 0x000000;  
			my_shadow.blurY = 0;  
			my_shadow.blurX = 0;  
			my_shadow.angle = 90;  
			my_shadow.alpha = .35;  
			my_shadow.distance = 5;  
			s.filters = [my_shadow];
		}
		
	}
}