package com.core 
{
	import com.core.factory.SoundFactory;
	import com.core.user.User;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.SoundMixer;
	import mochi.as3.*;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Services
	{
		private static var serviceProvider:String;
		public static var isConnected:Boolean = false;
		private static var showPreRoll:Boolean = false;		
		private static var preLoaderSurface:MovieClip;
		public static var d:EventDispatcher = new EventDispatcher();
		//INFO
		
		//Mochi
		public static const Game_ID:String = "91c8be99b14508aa";
        public static const AD_ID:String = "GetTheTreasure";     
	
		public function Services() 
		{
			super();			
		}
		
		public static function SetService(s:String):void
		{
			serviceProvider = s;
		}
		
		public static function Connect(surface:MovieClip):void
		{							
			MochiServices.connect( Game_ID, surface, onFailure ); 
			MochiServices.addEventListener( MochiServices.CONNECTED, handleConnection );
			MochiSocial.addEventListener( MochiSocial.LOGGED_IN, createUser );
			MochiInventory.addEventListener(MochiInventory.READY, inventoryReady);
			MochiSocial.addEventListener( MochiSocial.LOGGED_OUT, handleLogOut );
		}
		
		/*
		 * 
		 * 
		 * SETTING UP THE USER
		 * 
		 */ 
		private static function createUser(e:Object):void
		{			
			var u:User = new User();
			u.init(e.userProperties);
		}
		
		private static function inventoryReady(e:Object):void
		{
			User.SetInventory();
		}
		
		public static function ShowInterLevelAd():void
		{
			
			SoundMixer.stopAll();
				
			   MochiAd.showInterLevelAd( {
                id: Game_ID,             // This is the game ID for displaying ads!
                clip: Main.GetAdClip(),              // We are displaying in a container (which is dynamic)
                ad_finished:function ():void {
					SoundFactory.PlaySound("InGameMusic",true,true);	
					SoundFactory.PlaySound("Sea", true, false, .2);	},
			     ad_skipped:function ():void {
					SoundFactory.PlaySound("InGameMusic",true,true);	
					SoundFactory.PlaySound("Sea",true,false, .2);	}
            } );
		}
		
		private static function handleLogOut(e:Object):void
		{
			User.OnLogOut();
		}
		
		public static function RequestLogin():void
		{
			MochiSocial.requestLogin();
		}
		
		private static function handleConnection(e:*):void
		{		
			if (!isConnected)
			{				
				isConnected = true;															
				MochiServices.removeEventListener( MochiServices.CONNECTED, handleConnection );
			}
		}
		
		public static function ShowItem(s:String):void
		{
			switch(s)
			{
				case "Cannonball_Standard":
					﻿MochiCoins.showItem({item: "4bf9c0fdc74d7c29"});
					break;
				case "Cannonball_Exploding":
					﻿MochiCoins.showItem({item: "4421df3bb013b53e"});
					break;
				case "Cannonball_Triple":
					﻿MochiCoins.showItem({item: "88aab8306e538ea1"});
					break;
				case "Cannonball_Rubber":
					﻿MochiCoins.showItem({item: "2811f74e81f65f6e"});
					break;
			}
		}
		
		public static function ShowLeaderboard():void
		{
			switch(serviceProvider)
			{
				case "Mochi":					
					var o:Object = { n: [4, 11, 2, 1, 7, 13, 12, 1, 2, 3, 7, 6, 9, 5, 10, 12], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
					var boardID:String = o.f(0,"");
					MochiScores.showLeaderboard( { boardID: boardID } );
					break;
			}
		}
		
		public static function PostToStream():void
		{
			switch(serviceProvider)
			{
				case "Mochi":
					MochiSocial.postToStream( {
						message: "I'm totally posting this to my stream!"
					} );					
			}
		}
		
		public static function ShowStore():void
		{
			trace("Showing store");
			if (User.GetLogInStatus())
			{
				MochiCoins.showStore();
			}
			else 
			MochiSocial.requestLogin();
		}
		public static function IsTest():Boolean
		{
			var t:Boolean = false;
			
			if (serviceProvider == "Test")
			{ t = true;
				
			}
			
			return t;
		}
		
		public static function BeginPlay():void
		{
			switch(serviceProvider)
			{
				case "Mochi":
					MochiEvents.startPlay();
					break;
			}
		}
		
		public static function EndPlay():void
		{
			switch(serviceProvider)
			{
				case "Mochi":
					MochiEvents.endPlay();
					break;
			}
		}
		
		public static function TrackEvent(s:String, v:Number):void
		{
			switch(serviceProvider)
			{
				case "Mochi":						
					MochiEvents.trackEvent(s, v);
					break;
			}
		}
		
		public static function ShowLoginWidget(xvar:int = 10, yvar:int =0):void
		{
			switch(serviceProvider)
			{
				case "Mochi":
					MochiSocial.showLoginWidget( { x: xvar, y:yvar } );
					break;
			}
		}
		
		public static function HideLoginWidget():void
		{
			switch(serviceProvider)
			{
				case "Mochi":
					MochiSocial.hideLoginWidget();
					break;
			}
			
		}
			
		private static function onFailure(e:* = null):void
        {
			trace("services failed to connect for some reason...");
        }		
	}
}