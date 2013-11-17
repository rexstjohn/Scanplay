package ui 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Arrow extends Sprite
	{
		[Embed(source = '../Loader.swf', symbol = 'Arrow')]
		private var arrow:Class;
		
		
		public var arrowMovie:MovieClip;
		
		public function Arrow() 
		{
			super();
			
			arrowMovie = MovieClip(new arrow());
			addChild(arrowMovie);
			arrowMovie.stop();
			buttonMode = true;			
		}
		
		public function SetColor(_s:String):void
		{
			switch(_s)
			{
				case "Red":
					arrowMovie.gotoAndStop(3);					
					break;
				case "Blue":
					arrowMovie.gotoAndStop(2);
					break;
				case "Idle":
					arrowMovie.gotoAndStop(1);
					break;
			}
		}
		
		
		private function HandleClick(e:MouseEvent):void
		{
			if(rotation == 0)
			arrowMovie.gotoAndStop(3);
			else
			arrowMovie.gotoAndStop(2);
		}		
	}
}