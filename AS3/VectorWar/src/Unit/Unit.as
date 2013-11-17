package Unit 
{
	import Brain.Brain;
	import com.scanplay.utils.ColorManager;
	import Controller.Controller;
	import flash.display.MovieClip;
	import flash.events.DataEvent;
	import flash.events.EventDispatcher;
	import Level.Levels.GameLevel;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Unit extends MovieClip
	{
		public var health:int = 0;
		public var cm:ColorManager;
		public var attackState:String;
		public var motionState:String;
		public var healthState:String;
		public var owner:String;		
		public var speed:int;
		public var range:Number;
		public var d:EventDispatcher;
		public var attackSpeed:Number;
		public var attackDamage:int;
		public var immovable:Boolean = false;
		public var oreValue:int = 100;
		public var controller:Controller;
		public var brain:Brain;
		public var level:GameLevel;
		
		public function Unit(l:GameLevel ) 
		{
			super();
			level = l;
			cm = new ColorManager(this);	
			d = new EventDispatcher();				
		}		
		
		public function takeDamage(dmg:Number):void
		{
			health -= dmg;			
			if (health <= 0)
			{
				healthState = "Dead";
			}
		}
		
		public function explode():void
		{
		}
		
		public function destroy():void
		{
			brain.destroy();
		}
		
	}
}