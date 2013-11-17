package com.game.objects
{
	import adobe.utils.CustomActions;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import com.core.factory.AssetFactory;
	import adobe.utils.ProductManager;
	import Box2D.Collision.b2Bound;
	import Box2D.Dynamics.b2Body;
	import com.core.ObjectPool;
	import com.game.GameObject;
	import com.core.util.Utilities;
	import com.physics.GameWorld;
	import com.core.GameLevel;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author ...
	 */
	
	public class ArcticBackground extends Background
	{			
		//midground, foreground, background layers
		//each gets panned at a different speed
		//all are randomly generated
		private static var farGround:Array;
		private static var foreGround:Array;
		private static var backGround:Array;
		private static var midGround:Array;
		
		//critters
		private static var seagulls:Array;
		private static var clouds:Array;
		private static var narwhals:Array;
		private static var walruses:Array;
		private static var penguins:Array;
		private static var icefloes:Array;
		private static var icebergs:Array;
		private static var seagullShadows:Array;
		
		public static var bgSprite:Sprite;		
		
		public function ArcticBackground() 
		{
			
			super();			
			bgSprite = new Sprite();
			allObjects = new Array();
			
			//arrays of objects in the four depths
			farGround = new Array();
			icebergs = new Array();
			icefloes = new Array();
			foreGround = new Array();
			backGround = new Array();
			midGround = new Array();
			clouds = new Array();
			
			//specifics
			penguins = new Array();
			narwhals = new Array();
			walruses = new Array();
			seagulls = new Array();
			seagullShadows = new Array();
			
			//turn the stage blue
			Main.m_sprite.graphics.beginFill(0x0099ff);
			Main.m_sprite.graphics.drawRect( -1500, -1500, 5500, 5500);
			Main.m_sprite.graphics.endFill();
			
			var width:Number = Main.m_sprite.stage.stageWidth * 4;
			
			//first, create the water..this pans at normal speed along with the foreground
			generateScenery(1, "ArcticWater", new Point(1900, 0), farGround);
			generateScenery(1, "ArcticWater", new Point(2700, 0), farGround);
			generateScenery(1, "ArcticWater", new Point(0, 0), farGround);
			generateScenery(1, "ArcticWater", new Point(-1700, 0), farGround);
			generateScenery(1, "Sun", new Point(350, -100),farGround);
			
			//add clouds			
			generateRandomScenery(5, "ArcticCloud", new Point(width , 0), new Point(130, 0), new Point(6,3), clouds);
			
			//next, create the islands
			generateRandomScenery(3, "Seagull", new Point(width , 0), new Point(300, 250), new Point(2, 1), seagulls);
			generateRandomScenery(2, "Narwhal", new Point(width * 2, 0), new Point(350, 250), new Point(3,2), backGround);
			generateRandomScenery(1, "IcebergC", new Point(width , 0), new Point(310, 250), new Point(10,6), backGround); //tall green island, weird
			generateRandomScenery(1, "IcebergB", new Point(width , 0), new Point(310, 250), new Point(5,2), farGround); //long, flat 
			generateRandomScenery(1, "IcebergA", new Point(width , 0), new Point(310, 250), new Point(8, 5), farGround);			
			generateRandomScenery(1, "IcebergD", new Point(width, 0), new Point(290, 250), new Point(8,6), backGround); //tall green island, rounded
			generateRandomScenery(2, "Icefloe", new Point(width , 0), new Point(430, 400), new Point(5,3), backGround);

			//ship wreck bits
			generateRandomScenery(1, "IcebergB", new Point(width, 0), new Point(750, 550), new Point(3,1), foreGround);
			generateRandomScenery(1, "IcebergA", new Point(width, 0), new Point(750, 550), new Point(3,1), foreGround);
			generateRandomScenery(3, "ShipWreckBits", new Point(width, 0), new Point(750, 550), new Point(6,3), foreGround);
			
			//create a background graphic
			
			Main.m_sprite.addChild(bgSprite);
			var shadow:Sprite;
			var g:int;
			//create shadows for the seagulls
			for (g = 0; g < seagulls.length; g++)
			{
				shadow = new Sprite();
				shadow.graphics.beginFill(0x000000);
				shadow.graphics.drawCircle(0, 0, seagulls[g].width / 2);
				shadow.scaleY = .2;
				shadow.graphics.endFill();
				shadow.x = seagulls[g].x;
				shadow.y = seagulls[g].y + 40;				
				shadow.alpha = .15;
				shadow.mouseEnabled = false;
				seagullShadows.push(shadow);
				bgSprite.addChild(shadow);
			}
			var l:Sprite;
			//add penguins and walruses randomly on the ice bergs
			for each(l in icefloes)
			{
				generateRandomScenery(1, "Walrus",  new Point(l.x , l.x ), new Point(l.y ,l.y), new Point(6,3),walruses);		
			}
			var m:Sprite;
			for each(m in icebergs)
			{		
				if(contains(backGround, m))
			    generateRandomScenery(2, "Penguin", new Point(m.x + 40, m.x - 50), new Point(m.y,m.y-20), new Point(3,2),penguins);		
			}
				Main.m_sprite.addEventListener(Event.ENTER_FRAME, handleEnter, false,0,true);
		
		}
		
		private function contains(v:Array, s:Sprite):Boolean
		{
			return (!(v.indexOf(s) == -1));
		}
		
		private function handleEnter(e:Event):void
		{
			AnimateClouds();
			AnimateSeagulls();
		}
		
		public override function Pause():void
		{
			Main.m_sprite.removeEventListener(Event.ENTER_FRAME, handleEnter);
		}
		
		public override function Resume():void
		{
			Main.m_sprite.addEventListener(Event.ENTER_FRAME, handleEnter);
		}

		public function AnimateClouds():void
		{
			var g:int;
			for (g=0; g < clouds.length; g++)
			{
				clouds[g].x += 1 * (clouds[g].y / 500);
				
				if (clouds[g].x > 1800)
				clouds[g].x = -700;
			}
		}		
		
		public function AnimateSeagulls():void
		{
			var g:int;
			
			for (g = 0; g < seagulls.length; g++)
			{
				seagullShadows[g].x = seagulls[g].x += 1 * (seagulls[g].y / 500);
				 
				if (seagulls[g].x > 1800)
				seagullShadows[g].x = seagulls[g].x = -700;
			}			
		}
	
		private var asset:Sprite;
		
		private function generateScenery(count:int, type:String, _position:Point, parent:Array):void
		{
			var g:int;
			 for (g = 0; g < count; g++)
			{
				asset = ObjectPool.GetObjectAs(type);
				asset.x = _position.x;
				asset.y = _position.y;
				asset.mouseEnabled = false;
				parent.push(asset);
				allObjects.push(asset);
				bgSprite.addChild(asset);
			}
	
		}
		
		private function generateRandomScenery(count:int, type:String, _xRange:Point, _yRange:Point, _scalar:Point, parent:Array):void
		{
			var g:int ;
			 for (g= 0; g < count; g++)
			{
				asset = ObjectPool.GetObjectAs(type);
				asset.x = Utilities.GetRandomNumberInARange( _xRange.x,_xRange.y);
				asset.y = Utilities.GetRandomNumberInARange(_yRange.x, _yRange.y);
				asset.scaleX = asset.scaleY = Utilities.GetRandomNumberInARange(_scalar.x, _scalar.y) / 10;
				parent.push(asset);
				asset.mouseEnabled = false;
				allObjects.push(asset);
				if (parent == farGround)				
				AssetFactory.ApplyBlur(asset);
				
				bgSprite.addChild(asset);
				
				if (type == "Icefloe")
				icefloes.push(asset);				
				
				if (type.search("berg") != -1)
				icebergs.push(asset);
			}	
		}	
		
		public override function destroy():void
		{
			Main.m_sprite.removeEventListener(Event.ENTER_FRAME, handleEnter);
			
			while (allObjects.length > 0)
			{
				ObjectPool.ReturnObject(allObjects[0]);
				allObjects[0] = null;
				allObjects.splice(0, 1);				
			}
			
			farGround = null;
			backGround = null;
			midGround = null;
			foreGround = null;
			bgSprite = null;
			walruses = null;
			seagullShadows = null;
			seagulls = null;
			narwhals = null;
			penguins = null;
			clouds = null;
		}
	}
}