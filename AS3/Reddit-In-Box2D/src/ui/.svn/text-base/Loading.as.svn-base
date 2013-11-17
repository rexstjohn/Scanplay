package ui 
{
	import flash.display.MovieClip;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Loading extends Sprite
	{
		[Embed(source='../Loader.swf', symbol='LoadingBar')]
		private var loader:Class;
		public var loadClip:MovieClip;
		
		
		public function Loading() 
		{
			loadClip = MovieClip(new loader());
			addChild(loadClip);
			loadClip.gotoAndStop(1);
		}
		
		public function Update():void
		{
			
		}
		
	}

}