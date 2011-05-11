package
{
	import com.data.images.encoders.BitString;
	import com.photo.coloraverager.PhotoPixelator;
	import com.photo.coloraverager.PhotoSquare;
	import com.physics.primitives.Block2D;
	import com.physics.primitives.PhysicsObject;
	import com.physics.World;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class PhysicsMain extends Sprite 
	{
		protected static var sprite:Sprite;
		protected static var _stage:Stage;		
		
		//list of objects
		protected static var physicsObjects:Array;
		protected static var world:World;
		
		public function PhysicsMain():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			sprite = new Sprite();
			addChild(sprite);			
			_stage = stage;
			
			//create the world
			world = new World(sprite);
			
			
			addEventListener(Event.ENTER_FRAME, Update);
		}
		
		private static function Update(e:Event):void
		{
			World.Update();
			
			for each(var o:PhysicsObject in physicsObjects)
			{
				o.Update();
			}
		}
		
		public static function GetSprite():Sprite
		{
			return sprite;
		}
		
		public static function GetStage():Stage
		{
			return _stage;
		}
	}
	
}