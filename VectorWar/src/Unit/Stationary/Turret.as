package Unit.Stationary
{
	import Brain.Unit.TurretBrain;
	import flash.display.MovieClip;
	import flash.events.DataEvent;
	import Level.Battlefield;
	import Level.Levels.GameLevel;
	import Unit.Unit;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
    [Embed(source="assets.swf", symbol="Unit.Turret")]
	public class Turret extends Unit
	{
		public var Cannon:MovieClip;
		public var HitArea:MovieClip;
		public var GreenCircle:MovieClip;
		
		//unit variables
		public var rotationSpeed:Number = .3;
		public var turretRotationSpeed:Number = .5;
		
		public function Turret(l:GameLevel) 
		{
			super(l);
			owner = "Red";
			name = "Turret";	
			speed = 0;
			health = 300;
			range = 500;
			immovable = true;
			attackDamage = 50;
			HitArea.alpha = 0;
			Cannon.Origin.visible = false;
			attackSpeed = 2000;
			height = 36;
			width = 36;
			GreenCircle.visible = false;
			brain = new TurretBrain(this);	
		}
	}
}