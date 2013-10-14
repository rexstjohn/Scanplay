package com.core.factory 
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class SoundFactory
	{
		
		/*
		 * 
		 * SOUNDS
		 * 
		 * 
		 */  
		[Embed(source = 'assets/library.swf', symbol = 'sfx_seagull.mp3')]
		private var _seagull:Class;

		[Embed(source = 'assets/library.swf', symbol = 'sfx_yarg.mp3')]
		private var _yarg:Class;
		
		[Embed(source = 'assets/library.swf', symbol = 'sfx_shot.mp3')]
		private var _cannonblast:Class;
		
		[Embed(source = 'assets/library.swf', symbol = 'sfx_hit_metal.mp3')]
		private var _hitmetal:Class;
		
		[Embed(source = 'assets/library.swf', symbol = 'sfx_hit_treasure.mp3')]
		private var _treasurehit:Class;
		
		[Embed(source = 'assets/library.swf', symbol = 'sfx_hit_glass.mp3')]
		private var _glassshatter:Class;
		
		[Embed(source = 'assets/library.swf', symbol = 'InGameMusic.wav')]
		private var _ingamemusic:Class;
		
		[Embed(source = 'assets/library.swf', symbol = 'Ocean_1.wav')]
		private var _oceanambience:Class;
		
		[Embed(source = 'assets/library.swf', symbol = 'Splash_1.wav')]
		private var _splash1:Class;
		
		[Embed(source = 'assets/library.swf', symbol = 'sfx_powderkeg.mp3')]
		private var _powderkeg:Class;
		
		[Embed(source = 'assets/library.swf', symbol = 'Splash_2.wav')]
		private var _splash2:Class;
		
		[Embed(source = 'assets/library.swf', symbol = 'Splat_1.wav')]
		private var _splat1:Class;
		
		[Embed(source = 'assets/library.swf', symbol = 'Splat_2.wav')]
		private var _splat2:Class;
		
		[Embed(source = 'assets/library.swf', symbol = 'Splat_3.wav')]
		private var _splat3:Class;
		
		[Embed(source = 'assets/library.swf', symbol = 'Glass_Shatter_1.wav')]
		private var _shatter1:Class;
		 
		[Embed(source = 'assets/library.swf', symbol = 'sfx_click.mp3')]
		private var _buttonclick:Class;
		
		[Embed(source = 'assets/library.swf', symbol = 'Shatter.mp3')]
		private var _crash:Class;
		
		[Embed(source = 'assets/library.swf', symbol = 'WoodHit1.wav')]
		private var _woodhit1:Class;
		
		[Embed(source = 'assets/library.swf', symbol = 'WoodHit2.wav')]
		private var _woodhit2:Class;
		
		[Embed(source = 'assets/library.swf', symbol = 'WinMusic.wav')]
		private var _winmusic:Class;
		
		[Embed(source = 'assets/library.swf', symbol = 'LoseMusic.wav')]
		private var _losemusic:Class;		
		
		[Embed(source = 'assets/library.swf', symbol = 'Theme.wav')]
		private var _thememusic:Class;
		
		[Embed(source = 'assets/library.swf', symbol = 'Sea.wav')]
		private var _sea:Class;
		
		private static var sounds:Array;
		
		public function SoundFactory() 
		{
			sounds = new Array();
			
			//sounds
			AddAsset("Sound", "Seagull", _seagull);
			AddAsset("Sound", "Yarg", _yarg);
			AddAsset("Sound", "Splash_1", _splash1);
			AddAsset("Sound", "TreasureOpen", _treasurehit);
			AddAsset("Sound", "Splash_2", _splash2);
			AddAsset("Sound", "Splat_1", _splat1);
			AddAsset("Sound", "Splat_2", _splat2);
			AddAsset("Sound", "Splat_3", _splat3);
			AddAsset("Sound", "OceanAmbience", _oceanambience);
			AddAsset("Sound", "CannonBlast_1", _cannonblast);
			AddAsset("Sound", "Shatter_1", _shatter1);
			AddAsset("Sound", "WoodHit1", _woodhit1);
			AddAsset("Sound", "WoodHit2", _woodhit2);
			AddAsset("Sound", "ButtonClick", _buttonclick);
			AddAsset("Sound", "Crash", _crash);
			AddAsset("Sound", "PowderKeg", _powderkeg);
			AddAsset("Sound", "ShatterGlass", _glassshatter);
			AddAsset("Sound", "HitMetal", _hitmetal);
			AddAsset("Sound", "InGameMusic", _ingamemusic);
			AddAsset("Sound", "ThemeMusic", _thememusic);
			AddAsset("Sound", "WinMusic", _winmusic);
			AddAsset("Sound", "LoseMusic", _losemusic);
			AddAsset("Sound", "Sea", _sea);
		}
	
		//this allocates all the sounds
		//we only want to allocate sounds a single time
		private function AddAsset(type:String, key:String, mcClass:Class):void		
		{
			var newAsset:Object = new Object();
			var classDef:Class = mcClass;
			
			newAsset["type"] = type;
			newAsset["key"] = key;
			newAsset["class"] = new classDef;
			
			sounds.push(newAsset);
		}
		
		//get the sound
		public static function GetSound(key:String):Sound
		{
			var mc:Sound = null;
			
			for each(var s:Object in sounds)
			{
				if (s["key"] == key)
				{
					if (s["type"] == "Sound")
					{
						//this generates a brand new copy of our class asset
						mc = Sound(new s["class"]());
					}
				}
			}				
			
			return mc;					
		}
		
		public static var myChannel:SoundChannel = new SoundChannel();
		
		public static function StopAll():void
		{
			SoundMixer.stopAll();			
		}
			
		public static function PlaySound(key:String, loops:Boolean = false, stopAll:Boolean = false, volume:Number = 1):void
		{
			if (stopAll)
			SoundMixer.stopAll();
			
			for each(var s:Object in sounds)
			{
				if (s["key"] == key)
				{
					if (s["type"] == "Sound")
					{
						//this generates a brand new copy of our class asset
						if(loops)
						myChannel = Sound(s["class"]).play(0, 10);
						else
						myChannel = Sound(s["class"]).play(0);
						
						myChannel.soundTransform = new SoundTransform(volume);
					}
				}
			}							
		}
	}

}