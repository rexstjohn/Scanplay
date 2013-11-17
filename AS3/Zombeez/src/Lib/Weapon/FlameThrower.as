package Lib.Weapon 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import Lib.Weapon.Weapon;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class FlameThrower extends Weapon
	{
		public var Torso:MovieClip;
		
		public function FlameThrower() 
		{
			super();			
			Name = "FlameThrower";
			weaponName = Name;
		}
		
		public function init():void
		{
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		public function onMouseDown(e:MouseEvent):void
		{
			
		}
		
			
		public override function aimWeapon(mouseX:int, mouseY:int):void
		{			
			var p:Point = globalizeCoordinates(Torso.x,Torso.y);
			
			var dy:Number = mouseY - p.y;
			var dx:Number = mouseX - p.x;			
			var radAngle:Number = Math.atan2(dy, dx);
			var angle:Number = -int(radAngle * 360 / (Math.PI * 2));
			
			if (angle < 33 && angle > -30)
			{				
				// finds the angle in radians (flash works in radians not degrees)
				Torso.rotation = angle;
			}
		}
	}

}