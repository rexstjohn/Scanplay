package Lib.Projectile 
{
	import Lib.GameObject;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class Projectile extends GameObject
	{
		public var damage:int;
		public var speed:int;
		
		public function Projectile(t:String) 
		{
			super(t);			
		}
		
	}

}