package Lib.Sound 
{
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	import flash.media.*;
	import flash.events.*;
	import flash.net.URLRequest;
	
	public class SoundFactory
	{
		public var sounds:Array;		
		public var sndChannel:SoundChannel;
		public var music:Sound;
		public var sfx:Sound;
		public var currentMusic:String;
		
		public function SoundFactory() 
		{
			sounds = new Array();			
			sndChannel = new SoundChannel();
			currentMusic = "None";
			
			//create all the sounds
			var coinSound:CoinSound = new CoinSound();
			var winSound:YouWinSound = new YouWinSound();
			var loseSound:YouLoseSound = new YouLoseSound();
			var failSound:FailSound = new FailSound();
			var clickSound:ClickSound = new ClickSound();
			var slotMachine:SlotMachineSound = new SlotMachineSound();
			var changeWeapon:ChangeWeaponSound = new ChangeWeaponSound();		
			var projectorSound:ProjectorSound = new ProjectorSound();
			var iceShot:IceShot = new IceShot();
			var splatterSound:SplatterSound = new SplatterSound();
			var splatterSound2:SplatterSound2 = new SplatterSound2();	
			var themeMusic:ThemeMusic = new ThemeMusic();
			var fightMusic:FightMusic = new FightMusic();
			
			sounds.push(splatterSound);
			sounds.push(splatterSound2);
			sounds.push(coinSound);
			sounds.push(winSound);
			sounds.push(failSound);
			sounds.push(loseSound);
			sounds.push(clickSound);
			sounds.push(slotMachine);
			sounds.push(changeWeapon);
			sounds.push(themeMusic);
			sounds.push(fightMusic);
			sounds.push(projectorSound);
			sounds.push(iceShot);
			
		}
		
		public function playLoopByName(musicName:String):void
		{		
			if (currentMusic != musicName)
			{
				currentMusic = musicName;
				music = new Sound();
				sndChannel.stop();
								
				music = getSound(musicName);
				
				trace("SoundFactory::Playing::" + musicName);
				playMusic();
						
			}
		}
		
		public function playMusic():void
		{			
			sndChannel = music.play();
			sndChannel.addEventListener(Event.SOUND_COMPLETE, loopMusic);
			
		}

		public function loopMusic(e:Event):void
		{
			if (sndChannel != null)
			{
				sndChannel.removeEventListener(Event.SOUND_COMPLETE, loopMusic);
				playMusic();
			}
		}
		
		public function getSound(soundName:String):Sound
		{
			var snd:Sound;
			
			for (var g:* in sounds)
			{
				if (sounds[g].Name == soundName)
				{
					trace("got sound::"  + soundName);
					snd = sounds[g];
				}
			}
			
			return snd;
		}
		
		public function playSound(soundName:String):void
		{
			for (var g:* in sounds)
			{
				if (sounds[g].Name == soundName)
				{
					sndChannel = sounds[g].play();
				}
			}
		}
		
	}

}