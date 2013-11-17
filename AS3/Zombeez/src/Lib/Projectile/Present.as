package Lib.Projectile 
{
	import Lib.GameObject;
	import Lib.Projectile.Projectile;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class Present extends Projectile
	{
		
		public function Present() 
		{
			super("Present");
			Name = "Present";
			damage = 20;
			mouseEnabled = false;
		}
		
	}

}