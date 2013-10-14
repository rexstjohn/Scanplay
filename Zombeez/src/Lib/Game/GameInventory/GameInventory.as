package Lib.Game.GameInventory 
{
	import adobe.utils.CustomActions;
	import Lib.GameObject;
	import Lib.Item.StoreItem;
	
	/**
	 * ...
	 * @author Rex
	 */
	public class GameInventory extends GameObject
	{
		public var items:Array;
		
		public var Slot1:StoreItem;
		public var Slot2:StoreItem;
		public var Slot3:StoreItem;
		public var Slot4:StoreItem;
		public var Slot5:StoreItem;
		public var Slot6:StoreItem;
		
		public function GameInventory() 
		{
			super("GameInventory");			
		}
		
		public function init(i:Array):void
		{			
			items = i;
			
			Slot1 = items[0];
			Slot2 = items[1];
			Slot3 = items[2];
			Slot4 = items[3];
			Slot5 = items[4];
			Slot6 = items[5];
		}
		
	}

}