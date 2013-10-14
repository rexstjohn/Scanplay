package Lib.Sound 
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class CoinSound extends Sound
	{
		public var Name:String = "CoinSound";
		
		public function CoinSound(stream:URLRequest = null, context:SoundLoaderContext = null) 
		{
			super(stream, context);
			
			
		}
		
	}

}