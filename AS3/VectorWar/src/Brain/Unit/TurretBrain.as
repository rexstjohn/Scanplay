package Brain.Unit
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import Unit.Stationary.Turret;
	import Brain.Brain;
	import Level.Levels.GameLevel;
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class TurretBrain extends Brain
	{
		
		public function TurretBrain(t:Turret) 
		{
			unit = t;
		}
	}

}