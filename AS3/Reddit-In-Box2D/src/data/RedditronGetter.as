package data 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
    import com.adobe.serialization.json.JSON; 
	import flash.system.LoaderContext;
	import flash.system.Security;
	import objects.RedditPost;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class RedditronGetter
	{
		//xml feed
		private var redditRSSXML:XML;
		private var feedObject:Object;
		
		//loader
		private var request:URLRequest;
		private var loader:URLLoader;
		
		//reddit objects
		private var redditPosts:Array;
		
		//listener
		public var d:EventDispatcher;
		
		public var proxy:String  = "http://web.scanplaygames.com/Prototypes/reddit/proxy.php?url=";
		
		public function RedditronGetter() 
		{			
			redditPosts = new Array();
			d = new EventDispatcher();
		
		}	
		
		//gets the reddit RSS feed and 
		//dumps it in an xml
		public function UpdateData():void
		{
			request = new URLRequest(proxy + "http://www.reddit.com/.rss");
			loader = new URLLoader(request);
			
			loader.addEventListener(Event.COMPLETE, LoadXML);
			
			function LoadXML(e:Event):void
			{
				redditRSSXML = new XML(e.target.data);
				loader.removeEventListener(Event.COMPLETE, LoadXML);
				loader.close();			
				
				//trace the xml
				trace(redditRSSXML);
				
				//store the xml into an object we can use later
				feedObject = ParseXMLToObject(redditRSSXML);
				var count:int = 1;
				
				for each(var o:Object in feedObject.objects)
				{
					//check to make sure our objects are loaded correctly
					trace("title " + o.title);
					trace("link " + o.link);
					
					//create a reddit post
					redditPosts.push(new RedditPost( count, o.title, o.link,  o.description, o.date));
					count++;
				}
				
				//next, set the missing data we have to get from the JSON
				for each(var k:RedditPost in redditPosts)
				{
					k.SetPostDataFromURL();
				}
			}			
			
			loader.load(request);
		}
		
		
		public function GetData():Array
		{
			return redditPosts;
		}
		
		//parses the xml to objects
		protected function ParseXMLToObject(feedXML:XML):Object
		{					
			var newFeed:Object    =       new Object();
			var feedContent:Array = new Array();
		
			//capture all the objects
			var g:int;
			
			for (g = 0; g < feedXML.channel.item.length(); g++)
			{
				var newObject:Object     = new Object();
				newObject["title"]       = String(feedXML.channel.item[g].title);
				newObject["link"]        = String(feedXML.channel.item[g].link);
				newObject["guid"]        = String(feedXML.channel.item[g].guid);
				newObject["date"]        = String(feedXML.channel.item[g].pubDate);
				newObject["description"] = String(feedXML.channel.item[g].description);
			//	newObject["thumbnail"]   = String(feedXML.item[g].media:title);
				
				feedContent.push(newObject);					
			}			
			
			newFeed["objects"] = feedContent;	
			return newFeed
		}
	}
}