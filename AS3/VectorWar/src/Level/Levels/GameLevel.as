package Level.Levels 
{
	import flash.geom.Point;
	import Level.Battlefield;
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class GameLevel
	{
		public var map:Array = [];
		public var number:int = 0;
		public var name:String = "";		
		
		public var style:String = "default";	
		public var dimension:Point;
		public var gridSize:Point;
		
		//rendered objects
		public var units:Array = [];
		public var tiles:Array = [];
		
		//game related
		public var battlefield:Battlefield;
		
		public function GameLevel() 
		{
			dimension =  new Point(0, 0);
			gridSize = new Point (32, 32);
		}
		
	}

}