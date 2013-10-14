package Lib.Sound 
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class ProjectorSound extends Sound
	{
		public var Name:String = "ProjectorSound";
		
		public function ProjectorSound(stream:URLRequest = null, context:SoundLoaderContext = null) 
		{
			super(stream, context);
			
		}
		
	}

}