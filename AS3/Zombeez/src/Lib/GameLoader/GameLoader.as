package Lib.GameLoader 
{
	import flash.display.Loader;
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.system.LoaderContext;
	import Lib.GameEvent.GameEvent;
	import flash.utils.*;
	import flash.system.ApplicationDomain;
	import flash.system.SecurityDomain;
	import flash.system.Security;
	import flash.text.*;
	import Lib.Player.Player;
	
	/**
	 * ...
	 * @author Rex
	 */
	public class GameLoader extends EventDispatcher
	{
		public var loader:Loader;
		public var loadRequest:URLRequest;
		private var progressBarWidth:int = 500;
		
		//loader context
		private var context:LoaderContext;
		private var domain:ApplicationDomain;		
		
		public var loadingScreen:MovieClip = new MovieClip();
		public var stage:Stage;
		
		public function GameLoader(s:Stage) 
		{
			stage = s;		
			context = new LoaderContext();	
			context.applicationDomain = ApplicationDomain.currentDomain;
		}
		
		//this first loads the loading screen and loads the object into the "loadingScreen" movieclip
		//by default, we do not add this to the stage until the ad is done loading because we dont want the ad being
		//covered by the loading screen. In the mainview, when the ad finishes ( sends an "AdLoaded" event), we add the loading
		//screen to the stage so the user doesnt stare at a blank page for several seconds after the ad is done.
		public function load():void
		{
			var loadingLoader:Loader = new Loader();
			var req:URLRequest = new URLRequest("Assets/LoadingScreen.swf");
			
			loadingLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadingBarLoadProgress);
			loadingLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, doneLoadingLoadingBar);			
			loadingLoader.load(req,context);
						
			function loadingBarLoadProgress(e:ProgressEvent):void
			{
				var percent:Number = e.bytesLoaded/e.bytesTotal;
				trace("GameLoader::PercentLoaded::" + percent);
			}
			
			function doneLoadingLoadingBar(e:Event):void
			{
				trace("GameLoader::DoneLoading::LoadingScreen");
				loadingLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, loadingBarLoadProgress);
				loadingLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, doneLoadingLoadingBar);
								
				loadingScreen = MovieClip(MovieClip(loadingLoader.content).getChildAt(0));
				stage.addChild(loadingScreen);
				loadGameAssets();
			}	
			
			function loadGameAssets():void
			{			
				loader = new Loader();
				loadRequest = new URLRequest("Assets/GameAssets.swf");
				
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
								
				function loadProgress(e:ProgressEvent):void
				{
					if (stage.contains(loadingScreen))
					{
						var percent:Number = e.bytesLoaded/e.bytesTotal;
						trace("GameLoader::PercentLoaded::" + percent);
						loadingScreen.PercentLoaded.text = String(percent * 100);				
						loadingScreen.ProgressBar.width = String(percent * progressBarWidth);
					}
				}
				
				function loadComplete(e:Event):void
				{					
					trace("GameLoader::DoneLoading::Game Assets");
					loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, loadProgress);
					loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadComplete);
					
					stage.removeChild(loadingScreen);					
					stage.addChild(loader);					
					
					var done:GameEvent = new GameEvent("LoadComplete");
					dispatchEvent(done);
				}	
				
				loader.load(loadRequest,context);
			}
		}		
		
		public function getAssetClassByName(className:String):Class
		{
			//var c:Class = loader.content.loaderInfo.applicationDomain.getDefinition(className) as Class;
		//	var c:Class = ApplicationDomain.currentDomain.getDefinition(className) as Class;
			var c:Class = loader.content.loaderInfo.applicationDomain.getDefinition(className) as Class;
			return c;
			
		}
		
		public function getLoader():Loader
		{
			return loader;
		}
		
	}

}