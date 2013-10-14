package Lib.Projectile 
{
	import flash.display.MovieClip;
	import Lib.Projectile.Projectile;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class ShotGunShell extends Projectile
	{
		public var Tail:MovieClip;
		
		public function ShotGunShell() 
		{
			super("ShotGunShell");
			Name = "ShotGunShell";
			damage = 75;
			speed = 150;
			Tail.visible = false;
			
		}
		
	}

}