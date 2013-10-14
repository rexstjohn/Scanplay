package  
{
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author ScanPlayGames
	 * Where I keep all my game settings
	 */
	public class Settings
	{		
		//settings
		public static var mute:Boolean                   = false;
		public static var pirateGender:String            = "Female";
		
		public static function Mute():void
		{
			if (!mute)
			{
				mute = true;
				var trans:SoundTransform = new SoundTransform(0);
				SoundMixer.soundTransform = trans;
			}
			else
			{
				mute = false;
				var trans2:SoundTransform = new SoundTransform(1);
				SoundMixer.soundTransform = trans2;
				
			}
		}
	}
}