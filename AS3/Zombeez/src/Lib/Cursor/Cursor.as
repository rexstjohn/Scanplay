package Lib.Cursor 
{
	import Lib.GameObject;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class Cursor extends GameObject
	{
		
		public function Cursor() 
		{
			super("Cursor");
			mouseChildren = false;
			mouseEnabled = false;
		}
		
	}

}