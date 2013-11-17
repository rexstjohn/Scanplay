package Unit.Stationary 
{
	import Level.Levels.GameLevel;
	import Unit.Unit;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	[Embed(source='Assets.swf', symbol='Unit.Stationary.SpawnPad')]
	public class SpawnPad extends Unit
	{		
		public function SpawnPad(l:GameLevel) 
		{
			super(l);
			height = 36;
			width = 36;
		}
		
	}

}