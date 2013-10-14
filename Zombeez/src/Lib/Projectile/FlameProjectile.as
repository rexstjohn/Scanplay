package Lib.Projectile 
{
	import Lib.Projectile.Projectile;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class FlameProjectile extends Projectile
	{
		
		public function FlameProjectile() 
		{
			super("FlameProjectile");		
			Name = "FlameProjectile";
			damage = 150;
			speed = 150;			
		}
		
	}

}