package Level.Tiles 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	[Embed(source='Assets.swf', symbol='Level.Tiles.TileCorners')]
	public class TileCorners extends MovieClip
	{
		public var UpperLeft:MovieClip;
		public var UpperRight:MovieClip;
		public var LowerLeft:MovieClip;
		public var LowerRight:MovieClip;
		
		public var TopSide:MovieClip;
		public var BottomSide:MovieClip;
		public var LeftSide:MovieClip;
		public var RightSide:MovieClip;
		
		public function TileCorners() 
		{
			super();
			UpperLeft.visible = false;
			UpperRight.visible = false;
			LowerLeft.visible = false;
			LowerRight.visible = false;
			
			TopSide.visible = false;
			BottomSide.visible = false;
			LeftSide.visible = false;
			RightSide.visible = false;
		}
		
	}

}