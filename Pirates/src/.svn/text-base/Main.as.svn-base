package 
{
	import com.core.factory.ScriptFactory;
	import com.core.factory.SoundFactory;
	import com.game.ui.UpgradeScreen;
	import com.giblet.LevelEditor;
	import com.core.*;
	import com.physics.GameWorld;
	import com.core.factory.AssetFactory;
	import com.menu.factory.MenuFactory;
	import com.core.factory.MessageFactory;
	import com.core.user.UserData;
	import com.core.GameController;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.utils.*;
	import com.core.util.Utilities;
	import mochi.as3.*;
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public dynamic class Main extends MovieClip 
	{				
		static public var m_sprite:Sprite;
		static public var m_stage:Stage;
		static public var ad_clip:MovieClip;
		static public var gameController:GameController;
		
		//services
		public function Main():void 
		{	
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}		
		
		//======================
		// Member data
		//======================
		
		//factories
		public static var assetFactory:AssetFactory;
		public static var menuFactory:MenuFactory;
		public static var scriptFactory:ScriptFactory;
		public static var objectPool:ObjectPool;
		public static var soundFactory:SoundFactory;
		
		//other fun stuff
		public static var messageFactory:MessageFactory;
		public static var user:UserData;
		public static var levelEditor:LevelEditor;
		
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			m_stage = stage;
			m_sprite = new Sprite();
			addChild(m_sprite);			
			
			assetFactory     = new AssetFactory();
			soundFactory     = new SoundFactory();
			objectPool       = new ObjectPool(30);
			menuFactory      = new MenuFactory();
			messageFactory	 = new MessageFactory();
			user	         = new UserData();
			levelEditor	     = new LevelEditor();
			gameController   = new GameController();
			scriptFactory    = new ScriptFactory();	
			ad_clip  		 = new MovieClip();
			
			//create the main clip on the stage for mochi
			Main.m_stage.addChild(ad_clip);
			Services.SetService("Mochi");
			Services.Connect(ad_clip);
			
			//connect and show the game when we are done loading					
			MochiAd.showPreGameAd( { clip:ad_clip, id:Services.Game_ID, res:"800x600", ad_finished:  function ():void { GameController.HandleEvent("GameStart", "main"); }} );			
			Main.m_stage.addEventListener(Event.ENTER_FRAME, update);	
							
		}		
		
		private static function update(e:Event):void
		{
			if (m_stage.contains(ad_clip))
			m_stage.setChildIndex(ad_clip, m_stage.numChildren-1);
			else
			m_stage.addChild(ad_clip);
		}
		
		public static function ClearSprite():void
		{
			while (m_sprite.numChildren > 0)
			{
				m_sprite.removeChildAt(0);
			}
		}
		
		public static function GetAdClip():Sprite
		{
			return ad_clip;
		}
		
		public static function ClearStage():void
		{
			while (m_stage.numChildren > 1)
			{
				if(m_stage.getChildAt(0) != ad_clip)
				m_stage.removeChildAt(0);
			}
			
			Main.m_stage.addChild(m_sprite);			
		}		
	}	
}