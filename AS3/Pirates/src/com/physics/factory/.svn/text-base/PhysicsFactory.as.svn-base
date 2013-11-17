package com.physics.factory
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import com.core.ObjectPool;
	import com.core.util.Utilities;
	import flash.display.Sprite;
	import flash.display.Sprite;
	import Box2D.Dynamics.b2Body;
	import com.game.GameObject;
	import flash.geom.Point;
	import com.physics.GameWorld;
	import com.game.Water;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import com.core.factory.AssetFactory;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.Joints.b2PrismaticJointDef;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class PhysicsFactory
	{		
		//box2d helper objects
		private static var bodyDef:b2BodyDef = new b2BodyDef();
		private static var circleDef:b2CircleShape; 
		private static var boxDef:b2PolygonShape = new b2PolygonShape();		
		private static var pjDef:b2PrismaticJointDef = new b2PrismaticJointDef();
		private static var fixtureDef:b2FixtureDef = new b2FixtureDef();
		private static var body:b2Body;		
		private static var boxSprite:Sprite;
		
		//some general purpose reuseable vectors
		private static var centerVec:b2Vec2 = new b2Vec2(0, 0);
		private static var posVec:b2Vec2    = new b2Vec2(0, 0);
			
		public static function CreatePhysicsObject(_p:Point, _skin:String, shape:String, isStatic:Boolean = false, _radius:Number = 0, vertices:Array = null, _height:Number = 0, _width:Number = 0):Object		
		{
			var newObject:Object;
			
			//set the body as a dynamic
			if(!isStatic)
			{bodyDef.type = b2Body.b2_dynamicBody;}
			else { bodyDef.type = b2Body.b2_staticBody; }
			
			switch(shape)
			{
				case "Circle2D":
					newObject = CreateCircle2D(_p,_skin,_radius);
					break;
				case "Block2D":
					newObject = CreateBlock2D(_p, _skin);
					break;
				case "Polygon2D":
					break;
				case "Nail2D":
					newObject = CreateNail2D(_p, _skin);
					break;
				case "Platform2D":
					newObject = CreatePlatform2D(vertices, _skin); 
					break;
				case "VariableBlock2D":
					newObject = CreateVariableBlock2D(_p, _height, _width, _skin); 
					break;
			}
			
			return newObject;
		}
		
		//creates a block with an attached skin
		private static function CreateVariableBlock2D(_p:Point, _height:Number, _width:Number, _skin:String):Object
		{			
			//set the box information			
			boxDef.SetAsBox((_height/2)/ GameWorld.pixels_per_meter, (_width/2) / GameWorld.pixels_per_meter);
			bodyDef.position.Set((_p.x)/  GameWorld.pixels_per_meter, (_p.y ) /  GameWorld.pixels_per_meter);
			
			fixtureDef = new b2FixtureDef();
			fixtureDef.shape = boxDef;
			fixtureDef.density = .05;
			fixtureDef.friction = 0.3;
			fixtureDef.restitution = 0.4;
			
			//create the body
			body = GameWorld.m_world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			
			//attach a skin
			boxSprite = ObjectPool.GetObjectAs(_skin);
			boxSprite.x = (body.GetPosition().x * GameWorld.pixels_per_meter) ;
			boxSprite.y = (body.GetPosition().y * GameWorld.pixels_per_meter);
			
			//we have to make everything just a tiny bit smaller so it will fit in square spaces and tight areas nicely
			boxSprite.height = (_height );
			boxSprite.width =  (_width ) ;
			
			var newBlock2D:Object = new Object();
			newBlock2D["body"] = body;
			newBlock2D["sprite"] = boxSprite;
			
			//set the initial body position offsets
			posVec.x = (_p.x + (GameWorld.GridSize / 2)) / GameWorld.pixels_per_meter;
			posVec.y = (_p.y + (GameWorld.GridSize / 2)) / GameWorld.pixels_per_meter;
			body.SetPosition(posVec);
			
			return newBlock2D;
		}			
		//create a nail
		public static function CreateNail2D(_p:Point, _skin:String):Object
		{
			//set the box information			
			boxDef.SetAsBox((10)/ GameWorld.pixels_per_meter, (10) / GameWorld.pixels_per_meter);
			bodyDef.position.Set((_p.x)/  GameWorld.pixels_per_meter, (_p.y ) /  GameWorld.pixels_per_meter);
			
			fixtureDef = new b2FixtureDef();
			fixtureDef.shape = boxDef;
			fixtureDef.density = .05;
			fixtureDef.friction = 0.3;
			fixtureDef.restitution = 0.4;
			
			//create the body
			body = GameWorld.m_world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			
			//attach a skin
			boxSprite =ObjectPool.GetObjectAs(_skin);;
			boxSprite.x = (body.GetPosition().x * GameWorld.pixels_per_meter) ;
			boxSprite.y = (body.GetPosition().y * GameWorld.pixels_per_meter);
			
			//we have to make everything just a tiny bit smaller so it will fit in square spaces and tight areas nicely
			boxSprite.height = (10);
			boxSprite.width =  (10) ;
			
			var newNail2D:Object = new Object();
			newNail2D["body"] = body;
			newNail2D["sprite"] = boxSprite;
			
			//set the initial body position offsets
			posVec.x = (_p.x) / GameWorld.pixels_per_meter;
			posVec.y = (_p.y ) / GameWorld.pixels_per_meter;
			body.SetPosition(posVec);
			
			return newNail2D;			
		}
		
		//creates a simple circle	
		public static function CreateCircle2D(_p:Point, _skin:String ,_radius:Number):Object
		{
			//set the box information			
			circleDef = new b2CircleShape(_radius / GameWorld.pixels_per_meter);
			
			//set the fixture
			fixtureDef = new b2FixtureDef();
			fixtureDef.shape = circleDef;
			fixtureDef.density = 1;
			fixtureDef.friction = .4;
			fixtureDef.restitution = .3;
			
			bodyDef.position.Set((_p.x )/  GameWorld.pixels_per_meter, (_p.y ) /  GameWorld.pixels_per_meter);
			
			//create the body
			body = GameWorld.m_world.CreateBody(bodyDef);			
			body.CreateFixture(fixtureDef);		
			
			//attach a skin
			boxSprite = ObjectPool.GetObjectAs(_skin);
			boxSprite.x = (body.GetPosition().x * GameWorld.pixels_per_meter);
			boxSprite.y = (body.GetPosition().y * GameWorld.pixels_per_meter);
			boxSprite.height = _radius * 2;
			boxSprite.width = _radius * 2;
			
			var newSpriteCircle:Object = new Object();
			newSpriteCircle["body"] = body;
			newSpriteCircle["sprite"] = boxSprite;
			
			return newSpriteCircle;
		}
		
		//creates a block with an attached skin
		private static function CreateBlock2D(_p:Point, _skin:String):Object
		{			
			//set the box information			
			boxDef.SetAsBox((GameWorld.GridSize/2)/ GameWorld.pixels_per_meter, (GameWorld.GridSize/2) / GameWorld.pixels_per_meter);
			bodyDef.position.Set((_p.x)/  GameWorld.pixels_per_meter, (_p.y ) /  GameWorld.pixels_per_meter);
			
			fixtureDef = new b2FixtureDef();
			fixtureDef.shape = boxDef;
			fixtureDef.density = .05;
			fixtureDef.friction = 0.3;
			fixtureDef.restitution = 0.4;
			
			//create the body
			body = GameWorld.m_world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			
			//attach a skin
			boxSprite = ObjectPool.GetObjectAs(_skin);
			boxSprite.x = (body.GetPosition().x * GameWorld.pixels_per_meter) ;
			boxSprite.y = (body.GetPosition().y * GameWorld.pixels_per_meter);
			
			//we have to make everything just a tiny bit smaller so it will fit in square spaces and tight areas nicely
			boxSprite.height = (GameWorld.GridSize );
			boxSprite.width =  (GameWorld.GridSize ) ;
			
			var newBlock2D:Object = new Object();
			newBlock2D["body"] = body;
			newBlock2D["sprite"] = boxSprite;
			
			//set the initial body position offsets
			posVec.x = (_p.x + (GameWorld.GridSize / 2))/ GameWorld.pixels_per_meter;
			posVec.y = (_p.y + (GameWorld.GridSize / 2)) / GameWorld.pixels_per_meter;
			body.SetPosition(posVec);
			
			return newBlock2D;
		}				
		

		//platforms are special, their physical bodies have to be very thin to avoid upsetting nearby objects 
		//and to allow fine stacking
		public static function CreatePlatform2D(vertices:Array, _skin:String,  isThin:Boolean = true):Object
		{
			//create the body		
			var dx:Number = vertices[0].x - vertices[1].x;
			var dy:Number = vertices[0].y - vertices[1].y; 
			var length:Number = Utilities.GetDistanceInPixels2(vertices[0], vertices[1]) / 2;
			var angle:Number = -Utilities.GetAngleInRadians(vertices[0], vertices[1]);
			var thickness:Number = 5;
			var height:Number;
			var width:Number;
			
			if (isThin)
			{
			   height =  length * 2 ;
			   width = .025;
			}
			else
			{
			   height = length * 2 ;
			   width = thickness;				
			}						
			
			//set the box information			
			boxDef.SetAsBox((height/2)/ GameWorld.pixels_per_meter, (width/2) / GameWorld.pixels_per_meter);
		
			//create the fixture
			fixtureDef = new b2FixtureDef();
			fixtureDef.shape = boxDef;
			fixtureDef.density = .45;
			fixtureDef.friction = 0.3;
			fixtureDef.restitution = 0.4;
			
			//create the body
			body = GameWorld.m_world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			
			//attach a skin
			boxSprite = ObjectPool.GetObjectAs(_skin);
			boxSprite.x = vertices[0].x;
			boxSprite.y = vertices[0].y;
			
			//we have to make everything just a tiny bit smaller so it will fit in square spaces and tight areas nicely
			boxSprite.height = (height);
			boxSprite.width = (thickness*2 ) + 1 ;
			
			var newPlatform:Object = new Object();
			newPlatform["body"] = body;
			newPlatform["sprite"] = boxSprite;
			
			//setting the position sucks a huge fat fucking dick.			
			var realX:Number = (vertices[0].x) /  GameWorld.pixels_per_meter;
			var realY:Number = (vertices[0].y) /  GameWorld.pixels_per_meter;	
			
			//first, correct the lengths against the angle
			realX -= (Math.cos(angle) * (length)) / GameWorld.pixels_per_meter;
			realY -= (Math.sin(angle) * (length)) / GameWorld.pixels_per_meter;
			
			//now adjust for the thickness of the board
			realX  += (Math.cos(angle) * ((thickness))) / GameWorld.pixels_per_meter;
			realY  += (Math.sin(angle) * ((thickness))) / GameWorld.pixels_per_meter;
			
			
			if (angle == Math.PI)
			{
				realX  -= (Math.cos(angle) * ((thickness*2))) / GameWorld.pixels_per_meter;
				realY  -= (Math.sin(angle) * ((thickness*2))) / GameWorld.pixels_per_meter;
			}
			
			if (angle == 0)
			{
				realX  -= (Math.cos(angle) * ((thickness))) / GameWorld.pixels_per_meter;
				realY  -= (Math.sin(angle) * ((thickness))) / GameWorld.pixels_per_meter;
			}
			
			//set the positions
			posVec.x  = realX;
			posVec.y  = realY;
			body.SetPositionAndAngle(posVec, angle);
			
			return newPlatform;
		}	
		
	}

}