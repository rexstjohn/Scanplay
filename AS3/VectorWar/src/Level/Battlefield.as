package Level 
{
	import Controller.BattlefieldController;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	[Embed(source='Assets.swf', symbol='Level.Battlefield')]
	public class Battlefield extends MovieClip
	{				
		public var controller:BattlefieldController;
		public var sprite:Sprite;
		
		public function Battlefield(s:Sprite)
		{
			sprite = s;
			controller = new BattlefieldController(this);
		}
		
	}

}