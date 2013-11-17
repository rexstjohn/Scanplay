package Lib.GameEvent 
{
	import flash.events.Event;
	import Lib.Item.InventoryItem;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class InventoryEvent extends Event
	{
		public var command:String;
		public var inventoryItem:InventoryItem;
		
		public function InventoryEvent(c:String, item:InventoryItem) 
		{
			super("Update", bubbles, cancelable);
			command = c;
			inventoryItem = item;
		}
		
	}

}