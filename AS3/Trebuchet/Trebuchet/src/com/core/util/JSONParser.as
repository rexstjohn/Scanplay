package com.util
{
	import com.util.events.JSONDecodedEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class JSONParser extends EventDispatcher
	{
		private var urlReq:URLRequest;
		private var urlLoader:URLLoader;
		
		public function parse(_json:String):void
		{
			urlReq = new URLRequest(_json);
			urlLoader = new URLLoader(urlReq);
			urlLoader.addEventListener(Event.COMPLETE, onJSONLoaderComplete);
		}
		
		private function onJSONLoaderComplete(e:Event):void 
		{
			var raw:String = String(e.target.data);
	
			trace('JSON --------------------------------------');
			dispatchEvent(new JSONDecodedEvent(	JSON.decode(raw) as Array));
	
//			for (var i:int = 0; i < json.length; i++) 
//			{
//	//				trace('Name: ' + json[i].name);
//	//				trace('Last Name: ' + json[i].lastname);
//	//				trace('Location: ' + json[i].location);
//	//				trace('Department: ' + json[i].department);
//	//				trace('');
//			}
		}

	}
}