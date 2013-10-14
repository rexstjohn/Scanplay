package Lib.Sound 
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class ClickSound extends Sound
	{
		public var Name:String = "ClickSound";
		
		public function ClickSound(stream:URLRequest = null, context:SoundLoaderContext = null) 
		{
			super(stream, context);
			
		}
		
	}

}