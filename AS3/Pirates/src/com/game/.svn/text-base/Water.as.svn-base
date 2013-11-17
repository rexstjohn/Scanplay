package com.game
{
	import Box2D.Collision.b2Bound;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.Controllers.b2BuoyancyController;
	import com.physics.blocks.PhysicsObject;
	import com.game.GameObject;
	import com.game.fx.Splash;
	import flash.display.Sprite;
	import flash.geom.Point;
	import Main;
	import com.physics.GameWorld;
	import Box2D.Dynamics.b2Body;
	import com.core.*;
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class Water extends PhysicsObject
	{		
		//stuff
		public static var bc:b2BuoyancyController;	
		public var water:Sprite;		
		static public var waterLine:Number;
		private static var splash:Splash;
		
		public function Water( _height:Number) 
		{
			super();
			bc = new b2BuoyancyController();
			water = new Sprite();
			skin = new Sprite();
			
			waterLine = _height + (GameWorld.GridSize);
			//configure the controlller
			bc.normal.Set(0,-1);
			bc.offset = ( -waterLine) / GameWorld.pixels_per_meter ;
			bc.density = 2.0;
			bc.linearDrag = 5;
			bc.angularDrag = 2;
			
			//create the water graphic
			Main.m_sprite.addChild(water);
			water.graphics.lineStyle(.3,0x00ff00);
			water.graphics.drawRect(0,  0, Main.m_stage.stageWidth * 4, 600);
			water.graphics.endFill();
			water.alpha = 0;			
			water.y = waterLine;			
			water.x -= Main.m_stage.stageWidth / 2;
			
			//create the body
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.type = b2Body.b2_staticBody;		
			body = GameWorld.m_world.CreateBody(bodyDef);
			body.SetPosition(new b2Vec2(0 / GameWorld.pixels_per_meter, (_height * 2)/ GameWorld.pixels_per_meter));
			
			//add the controller to te world
			GameWorld.m_world.AddController(bc); 
		}				
		
		public static function CreateSplash(x:Number):void
		{
			splash = new Splash(new Point(x, waterLine));
		}
		
		static public function AddFloatingBodies(objects:Array):void
		{
			var o:PhysicsObject;
			
			for each(o in objects)
			{
				if(o.isFloating)
				AddFloatingBody(o.GetBody());
			}
		}
		
		static public function AddFloatingBody(b:b2Body):void
		{			
			bc.AddBody(b);
		}
			
		static public function RemoveFloatingBody(b:b2Body):void
		{
			bc.RemoveBody(b);
		}
		public function destroy():void
		{			
			if (Main.m_sprite.contains(water))
			Main.m_sprite.removeChild(water);
			
			GameWorld.m_world.RemoveController(bc);
			
			water = null;
			water = null;
			bc = null;
		}
	}
}