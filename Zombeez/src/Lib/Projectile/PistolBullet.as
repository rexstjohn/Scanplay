package Lib.Projectile 
{
	import flash.display.MovieClip;
	import Lib.Projectile.Projectile;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class PistolBullet extends Projectile
	{
		public var Tail:MovieClip;
		
		public function PistolBullet() 
		{
			super("PistolBullet");
			Name = "PistolBullet";
			damage = 35;
			speed = 150;
			Tail.visible = false;
		}
		
	}

}