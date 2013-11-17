package com.physics.blocks 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import com.core.factory.AssetFactory;
	import flash.display.MovieClip;
	import com.physics.GameWorld;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.core.util.Utilities;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Polygon2D extends PhysicsObject
	{
		protected var polyShape:b2PolygonShape;
		public var vertices:Array;
		protected var texture:Sprite;
		protected var key:String;
		
		public function Polygon2D(_points:Array, _key:String) 
		{			
			super();
			
			vertices = new Array();
			key = _key;
			//create the shape outlin
			//there is a huge problem with polygons that are not fully convex...
			//all points MUST be convex to one another
			//or you will have endless issues.
			for ( var g:int = 0; g < _points.length; g++)
			{
				vertices[g] = new b2Vec2();
				vertices[g].Set( (_points[g].x -  Utilities.GetCentroid(_points).x) / GameWorld.pixels_per_meter, (_points[g].y -  Utilities.GetCentroid(_points).y)/ GameWorld.pixels_per_meter);
			}						
			
			polyShape = new b2PolygonShape();
			polyShape.SetAsArray( vertices, vertices.length );			
			
			//create the fixture
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = polyShape;
			fixtureDef.density = 1.0;
			fixtureDef.friction = 0.3;
			fixtureDef.restitution = .2;
			
			//create the body and apply my fixture
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.type = b2Body.b2_dynamicBody;	
			bodyDef.position.Set(Utilities.GetCentroid(_points).x / GameWorld.pixels_per_meter, Utilities.GetCentroid(_points).y / GameWorld.pixels_per_meter);
			body = GameWorld.m_world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
							
			//Water.AddFloatingBody(body);
			Draw();			
			
			canBeNailed = true
		}		
		
		private function Draw():void
		{
			skin = new Sprite();
			texture = new Sprite();
		    texture = AssetFactory.GetSprite(key);
			texture.scaleX  = texture.scaleY = 1.7;
			
			//centroid
			var centroid:Point = Utilities.GetCentroid(vertices);
			texture.x = (centroid.x * GameWorld.pixels_per_meter) + (texture.width / 2);
			texture.y = (centroid.y * GameWorld.pixels_per_meter) + (texture.height / 2);
			 
			// Main.m_sprite.addChild(texture			 
			skin.graphics.lineStyle(2);
			skin.graphics.beginFill(0xFF0000);	
			skin.graphics.moveTo(vertices[0].x * GameWorld.pixels_per_meter, vertices[0].y * GameWorld.pixels_per_meter);	
			
			for ( var g:int = 0; g < vertices.length; g++)
			{				
				var p:Point = new Point(vertices[g].x, vertices[g].y);
				
				//move the pen to the first vertice
				var gx:int = Math.round(p.x * GameWorld.pixels_per_meter);
				var gy:int = Math.round(p.y * GameWorld.pixels_per_meter);
				
				if (g < vertices.length - 1)
				{
					var p2:Point = new Point(vertices[g + 1].x, vertices[g + 1].y);
					var gx1:int = Math.round(p2.x * GameWorld.pixels_per_meter);
					var gy1:int = Math.round(p2.y * GameWorld.pixels_per_meter);
				}
				
				//draw to the next line in the array
				if(g  < vertices.length - 1)
				skin.graphics.lineTo(gx1, gy1);
				else
				skin.graphics.lineTo(vertices[0].x * GameWorld.pixels_per_meter, vertices[0].y * GameWorld.pixels_per_meter);
				
			}			
			
			skin.graphics.endFill();			
			texture.mask = skin;
			
			Main.m_sprite.addChild(skin);
			texture.x -= texture.width / 2;
			texture.y -= texture.height / 2;
			Main.m_sprite.addChild(texture);			
			
			switch(key)
			{
				case "WoodTexture":
				case "GlassBlock":
				MovieClip(texture).stop();
				break;
			}
		}
		
		public function GetCentroid():Point
		{
			return Utilities.GetCentroid(vertices);
		}
		
		protected override function Update(e:Event):void
		{
			skin.x = (body.GetPosition().x * GameWorld.pixels_per_meter);
			skin.y = (body.GetPosition().y * GameWorld.pixels_per_meter);
			
			skin.rotation  = texture.rotation = body.GetAngle() * ( 180 / Math.PI);				
			texture.x = (body.GetWorldCenter().x * GameWorld.pixels_per_meter);	
			texture.y =(body.GetWorldCenter().y * GameWorld.pixels_per_meter);
		}
	}
}