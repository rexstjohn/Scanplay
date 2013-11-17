package 
{
	import data.RedditronGetter;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.system.Security;
	import objects.RedditPost;
	import physics.Block2D;
	import physics.PhysicsWorld;
	import ui.Grokulator;
	import ui.Loading;
	import ui.LogoBlock;
	import ui.RedditPost2D;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Main extends Sprite 
	{
		[Embed(source = 'reddit.png')]
		private  var reddit:Class;
		
		private static var redditron:RedditronGetter;
		private static var world:PhysicsWorld;		
		private static var _sprite:Sprite
		private static var _stage:Stage;
		
		//array of posts
		private static var posts:Array;
		
		//loader
		private static var loader:Loading;
		private static var loaded:Boolean = false;
		
		//grokulatoir
		private static var grokulator:Grokulator;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point

			_sprite = new Sprite();
			addChild(_sprite);
			_stage = stage;
			
			posts = new Array();
			
			//create some other stuff
			world = new PhysicsWorld();
			redditron = new RedditronGetter();
			
			//create the loading graphic
			loader = new Loading();
			addChild(loader);
			loader.x = stage.stageWidth / 2;
			loader.y = stage.stageHeight / 2;
			
			
			var logo:LogoBlock = new LogoBlock(1100, 100);
			_stage.addChild(logo);
			
			//initialize our data
			redditron.UpdateData();		
			
			//spawn in blocks based on the data
			var data:Array = redditron.GetData();			
			
			addEventListener(Event.ENTER_FRAME, Update);
			
		}		
		
		public static function AddPost(_p:RedditPost):void
		{
			loader.loadClip.nextFrame();
			loader.loadClip.nextFrame();
			if(posts.length < 15)
			{
				posts.push(_p);
			}
			
			if(posts.length == 15 && !loaded)
			{AddPostsAndSort(); loaded = true;	}
		}	
		
		public static function GetStage():Stage
		{
			return _stage;
		}
		
		protected static function AddPostsAndSort():void
		{
			
			//create the grokulator
			grokulator = new Grokulator();
			
			loader.visible = false;
			var k:int = 0;
			var size:Number = 130;//o.GetUpVotes() * .15;
			
			for each(var o:RedditPost in posts)
			{
				k++;		
				o.SetNumber(k);			
				var b:RedditPost2D= new RedditPost2D(o, -250, -1500 + (k * 150), size, size);
				Main.AddChild(b);	
				Grokulator.AddGrok(o);
			}
			
		}
		
		public static function AddChild(s:Sprite):void
		{
			_sprite.addChild(s);
		}
		
		public static function RemoveChild(s:Sprite):void
		{
			if (_sprite.contains(s))
			_sprite.removeChild(s);
		}
		
		public static function GetSprite():Sprite
		{
			return _sprite;
		}
		
		private static function Update(e:* = null):void
		{
			PhysicsWorld.Update();
			
			if(grokulator)
			Grokulator.Update();
			
			if (loaded)
			{
				//handle the pan
				if (_stage.mouseY < 50 && (_sprite.y < 500))
				_sprite.y += 5;
				
				if (_stage.mouseY >= 1000&& (_sprite.y > -1500))
				_sprite.y -= 5;
			}
		}
	}	
}