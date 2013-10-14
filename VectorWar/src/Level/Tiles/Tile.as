package Level.Tiles 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	[Embed(source='Assets.swf', symbol='Level.Tiles.Tile')]
	public class Tile extends MovieClip
	{
		public var Type:String;
		public var Corners:TileCorners;
		
		public function Tile(t:String) 
		{
			super();
			gotoAndStop(t);
			Corners.stop();
			Type = t;
			height = 36;
			width = 36;  
			
		}
		
	}

}