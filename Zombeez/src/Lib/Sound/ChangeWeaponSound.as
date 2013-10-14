package Lib.Sound 
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class ChangeWeaponSound extends Sound
	{
		public var Name:String = "ChangeWeaponSound";
		
		public function ChangeWeaponSound(stream:URLRequest = null, context:SoundLoaderContext = null) 
		{
			super(stream, context);
			
		}
		
	}

}