package objects 
{
	import com.adobe.images.BitString;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import com.adobe.serialization.json.JSON;
	import flash.events.Event;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import physics.Block2D;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class RedditPost
	{
		protected var upVotes:int; //count of upvotes
		protected var downVotes:int; //count of downvotes
		protected var linkUrl:String;   //url for the link
		protected var redditUrl:String;
		protected var authorName:String; //name of the author
		protected var commentCount:int; //number of comments
		protected var title:String; //title of the post
		protected var date:String;  //date of the post
		protected var thumbnailPNG:String; //url for the png
		protected var description:String; //a mass of crap that comes in the rss feed
		protected var subreddit:String; //subreddit this belongs to
		protected var selftext:String; //the self text that sometimes appears
		protected var isSelfPost:Boolean; //is this a self post
		protected var thumbnail:String;
		protected var score:int;
		
		//the thumbnail image
		protected var thmIMG:Bitmap;
		
		
		public var proxy:String  = "http://web.scanplaygames.com/Prototypes/reddit/proxy.php?url=";
		//has this post been intitialized?
		protected var initialized:Boolean = false;
		
		//number of the post
		protected var number:int;
		
		public function RedditPost(_number:int, _title:String,  _redditLink:String, _description:String, _date:String) 
		{
			title = _title;
			description = _description;
			redditUrl  = _redditLink;
			date = _date;
			number = _number;
			
			//set the absolute link url
			//we have to do some bullshit to get it out of the rss feed
			var end:int = description.search("link");
			var start:int = description.search("<br/> <a href=");
			var _l:String = description.substr(start + 14, (end - 2)  - (start + 14));
			linkUrl = _l;
			
			//trim the quotation marks
			var myPattern:RegExp = /\"/;
			linkUrl = linkUrl.replace(myPattern, "");
			linkUrl = linkUrl.replace(myPattern, "");
			//linkUrl = linkUrl.substr(1, linkUrl.length - 2);
			trace("link is " + _l);
		}
		
		public function GetNumber():int
		{
			return number;
		}
	
		public function SetNumber(_n:int):void
		{
			number = _n;
		}
		
		//gets the missing data that we have to get with json
		public function SetPostDataFromURL():void
		{			
			trace("attemping to load this: " + "http://www.reddit.com/api/info.json?url=" + linkUrl);
			var request:URLRequest = new URLRequest(proxy + "http://www.reddit.com/api/info.json?url=" + linkUrl);
			var loader:URLLoader = new URLLoader(request);	
			
			loader.addEventListener(Event.COMPLETE, LoadJSON);
			
			function LoadJSON(e:Event):void
			{
				//decode the data
                var jsonData:Object = JSON.decode(e.target.data);
				trace("Loading from link: " + linkUrl);
				
				if ((jsonData.data.children.length > 0) && jsonData.data.children["0"].data)
				{
					//get all the rest of the reddit data here
					authorName   = jsonData.data.children["0"].data.author;
					commentCount = jsonData.data.children["0"].data.num_comments;
					upVotes      =  jsonData.data.children["0"].data.ups;
					downVotes    =  jsonData.data.children["0"].data.downs;
					subreddit    =  jsonData.data.children["0"].data.subreddit;
					isSelfPost   = jsonData.data.children["0"].data.is_self;
					selftext     = jsonData.data.children["0"].data.selftext;
					thumbnail    = jsonData.data.children["0"].data.thumbnail;
					score        = jsonData.data.children["0"].data.score;
					initialized = true;
					AddPost();
					
			
					if(thumbnail && (thumbnail != "/static/noimage.png"))
					GetThumbnailFromURL(); //gets the thumbnail for this post
				}
				
				loader.removeEventListener(Event.COMPLETE, LoadJSON);			
			}
			
			loader.load(request);       	
		}
		
		public function GetThumbnailFromURL():void
		{
			trace("Getting image..." + thumbnail);
			var lc:LoaderContext = new LoaderContext();
			lc.checkPolicyFile = false; // bypass security sandbox / policy file - does this effect quality when scaling? 
			
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.INIT, onImageLoaded);

			// load new url
			var _myURLRequest:URLRequest = new URLRequest(proxy + thumbnail);
			loader.load(_myURLRequest, lc);
			
			function onImageLoaded(e:Event):void
			{
					loader.contentLoaderInfo.removeEventListener(Event.INIT, onImageLoaded);
				 // Main.GetSprite().addChild(loader);
				 thmIMG = Bitmap(loader.content);
			}
			
		}
		
		public function GetThumbnailImage():Bitmap
		{
			return thmIMG;
		}
		
		public function GetThumbnail():String
		{
			return thumbnail;
		}
		
		public function GetScore():int
		{
			return score;
		}
		
		public function GetDescription():String
		{
			return description;
		}
		
		public function GetSubreddit():String
		{
			return subreddit;
		}
		
		public function GetAuthor():String
		{
			return authorName;
		}
		private function AddPost():void
		{
			Main.AddPost(this);
		}
		
		public function GetTitle():String
		{
			return title;
		}
		public function IsInitialized():Boolean
		{
			return initialized;
		}
		
		public function GetUpVotes():int
		{
			return upVotes;
		}
		
		public function GetDownVotes():int
		{
			return downVotes;
		}
		
		public function SetVotes(_up:int, _down:int):void
		{
			upVotes = _up;
			downVotes = _down;
		}
		
		public function SetAuthor(_author:String):void
		{
			authorName = _author;
		}
		
		public function SetComments(_comments:int):void
		{
			commentCount = _comments;
		}
		
		public function GetLink():String
		{
			return linkUrl;
		}
	}

}