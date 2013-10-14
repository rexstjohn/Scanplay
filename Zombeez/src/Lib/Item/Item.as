package Lib.Item 
{
	import Lib.GameObject;
	import Lib.Sound.SoundFactory;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Item extends GameObject
	{		
		public var itemName:String;
		public var itemType:String;	
		public var maxQuantity:int;
		public var currentQuantity:int;
		public var ammoCost:int;
		
		//is the item a premium item (costs real money)
		public var isPremium:Boolean = false;
		
		public function Item(t:String) 
		{
			super(t);			
		}		
	}
}