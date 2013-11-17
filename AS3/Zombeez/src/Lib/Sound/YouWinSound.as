package Lib.Sound 
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class YouWinSound extends Sound
	{
		
		public var Name:String = "YouWinSound";
		public function YouWinSound(stream:URLRequest = null, context:SoundLoaderContext = null) 
		{
			super(stream, context);
			
		}
		
	}

}