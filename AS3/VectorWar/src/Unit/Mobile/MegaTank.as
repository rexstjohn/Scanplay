package Unit.Mobile 
{
	import Controller.MegaTankController;
	import flash.display.MovieClip;
	import Level.Levels.GameLevel;
	import Unit.Unit;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	
	[Embed(source='Assets.swf', symbol='Unit.Mobile.MegaTank')]
	public class MegaTank extends Unit
	{
		public var GreenCircle:MovieClip;
		public var HitArea:MovieClip;
		public var Chasis:MovieClip;
		public var Cannon:MovieClip;
		
		public function MegaTank(l:GameLevel) 
		{
			super(l);
			controller = new MegaTankController(this);
			speed = 3;
			height = 36;
			width = 36;
			
			GreenCircle.visible = false;
			HitArea.visible = false;
		}
		
	}

}