package com.util.events
{
	import flash.events.Event;

	public class JSONDecodedEvent extends Event
	{
		private static const JSON_DECODED_EVENT:String = "JSON DECODED EVENT";
		private var _result:Array;
		
		public function JSONDecodedEvent(_result:Array)
		{
			super(JSON_DECODED_EVENT, bubbles, cancelable);
			this._result = _result;
		}
		
		public function get result():Array
		{
			return _result;
		}		
	}
}