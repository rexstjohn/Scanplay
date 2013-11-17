package Lib.Tools
{
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	import adobe.utils.ProductManager;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import mochi.as3.*;	 
	import flash.system.Security;
	import flash.display.*;
	import flash.errors.*;    
	import flash.events.IOErrorEvent;
	 
	public class MochiTools extends EventDispatcher
	{
		public var _mochiads_game_id:String = "418dfe5f83af8134";
        public static var GAME_OPTIONS:Object;
		public var rt:DisplayObject;
		public var adDimensionX:int;
		public var adDimensionY:int;
		public var adRes:String;
		public var testMode:Boolean = false;
		
		public function MochiTools(roote:DisplayObject, adResX:int, adResY:int, testMd:Boolean)
		{
			rt = roote;
			adDimensionX = adResX;
			adDimensionY = adResY;
			adRes = String(adDimensionX) + "x" + String(adDimensionY);
			testMode = testMd;
		}
		
		//connect to mochi
		public function connect():void
		{			
			//register safe domains
			var domains:Array = new Array("gameplay.mochimedia.com", "mochiads.com", "*", "coins.mochiads.com", "www.mochiads.com", "http://www.mochiads.com");			
			for (var g:* in domains)
			{				
				Security.allowDomain(g);
				Security.allowInsecureDomain(g);
			}
			
			//connect to mochi
			MochiServices.connect(_mochiads_game_id, rt, onConnectError);
			
			function onConnectError(status:String):void 
			{
				// handle error here...
			}
			
			//set whether we are in test mode or not
			
			if (testMode)
			{
				GAME_OPTIONS = { id: "test", res:adRes };
			}
			else
			{
				GAME_OPTIONS = { id: _mochiads_game_id, res:adRes };
			}
			
		}
		
		public function showLogin():void
		{
            MochiSocial.showLoginWidget( { x:330, y:360 } );
		}
		
		public function hideLogin():void
		{
			MochiSocial.hideLoginWidget(); // You can also pass a x,y - MochiSocial.showLoginWidget({x:330, y:360})
		}
		
		//this is code for showing an interstitial advertisement		
		public function showInterstitial():void
		{
			var opts:Object = { }; //options we pass to configure the mochi ad			
			var did_load:Boolean;
			
            for (var k:String in GAME_OPTIONS) 
			{
                opts[k] = GAME_OPTIONS[k];
            }

			//custom functions for handling advertising events
            opts.ad_started = function ():void 
			{
				trace("Ad started!");
                did_load = true;
            }
					
            opts.unloadAd = function ():void 
			{ trace("Ad unloaded");   }
			

			//dispatch an event when the ad has finished showing
            opts.ad_finished = function ():void 
			{
				trace("Ad Loaded");  				
				var adLoaded:Event = new Event("AdFinished");
				dispatchEvent(adLoaded);
			}

            opts.clip = rt;
            opts.skip = false; //make the ad impossible to skip
			
			MochiAd.showInterLevelAd(opts);
		}
		
		//this is code for showing a pregame load advertisement		
		public function showPreGameAd(surface:DisplayObject):void
		{
            var opts:Object = { }; //options we pass to configure the mochi ad
			
			var did_load:Boolean;
			
            for (var k:String in GAME_OPTIONS) 
			{
                opts[k] = GAME_OPTIONS[k];
            }

			//custom functions for handling advertising events
            opts.ad_started = function ():void 
			{
				trace("Ad started!");
                did_load = true;
				
				var adLoaded:Event = new Event("AdStarted");
				dispatchEvent(adLoaded);
            }
			
            opts.adLoaded = function ():void 
			{ trace("Ad Loaded");   }			
			
            opts.unloadAd = function ():void 
			{ trace("Ad unloaded");   }
			
            opts.adjustProgress = function ():void 
			{ trace("Ad PRogress");   }

			//dispatch an event when the ad has finished showing
            opts.ad_finished = function ():void 
			{
				trace("Ad Loaded");  
				
				var adLoaded:Event = new Event("AdFinished");
				dispatchEvent(adLoaded);
			}

            opts.clip = surface;
            opts.skip = false; //make the ad impossible to skip

            MochiAd.showPreGameAd(opts);
		}
		
		//this is code for showing a preroll advertisement		
		public function showPreRollAd(surface:DisplayObject):void
		{
            var opts:Object = { }; //options we pass to configure the mochi ad
			
			var did_load:Boolean;
			
            for (var k:String in GAME_OPTIONS) 
			{
                opts[k] = GAME_OPTIONS[k];
            }

			//custom functions for handling advertising events
            opts.ad_started = function ():void 
			{
				trace("Ad started!");
                did_load = true;
				
				var adLoaded:Event = new Event("AdStarted");
				dispatchEvent(adLoaded);
            }
			
            opts.adLoaded = function ():void 
			{ trace("Ad Loaded");   }			
			
            opts.unloadAd = function ():void 
			{ trace("Ad unloaded");   }
			
            opts.adjustProgress = function ():void 
			{ trace("Ad PRogress");   }

			//dispatch an event when the ad has finished showing
            opts.ad_finished = function ():void 
			{
				trace("Ad Loaded");  
				
				var adLoaded:Event = new Event("AdFinished");
				dispatchEvent(adLoaded);
			}

            opts.clip = surface;
            opts.skip = false; //make the ad impossible to skip

            MochiAd.showPreloaderAd(opts);
		}
		
	}

}