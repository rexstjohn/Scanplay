package Lib.GameEvent 
{
	import flash.events.Event;
	import Lib.Item.StoreItem;
	/**
	 * ...
	 * @author Rex
	 */
	public class StoreEvent extends Event
	{
		public var command:String;
		public var storeItem:StoreItem;
		
		public function StoreEvent(c:String, i:StoreItem) 
		{
			command = c;
			storeItem = i;
			super("Update");
		}
		
	}

}