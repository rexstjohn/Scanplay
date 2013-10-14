package Lib.Projectile 
{
	import Lib.Projectile.Projectile;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class IceProjectile extends Projectile
	{
		
		public function IceProjectile() 
		{
			super("IceProjectile");
			Name = "IceProjectile";
			damage = 30;
			speed = 25;			
		}		
	}
}