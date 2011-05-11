package  com.physics.primitives 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import com.physics.World;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Floor
	{		
		private var body:b2Body;
		private var bodyDef:b2BodyDef;
		private var fixtureDef:b2FixtureDef;
		private var boxDef:b2PolygonShape;
		
		public function Floor(_x:Number = 0, _y:Number = 600) 
		{			
			//create the box definition		
			boxDef                 = new b2PolygonShape();
			bodyDef                = new b2BodyDef();	
			fixtureDef             = new b2FixtureDef();

			//create the boxdef
			boxDef.SetAsBox(1000 / World.scale, 50 / World.scale);
			bodyDef.type = b2Body.b2_staticBody;
			
			//set the fixture
			fixtureDef.shape       =  boxDef;
			fixtureDef.density     = .05;
			fixtureDef.friction    = 0.3;
			fixtureDef.restitution = 0.4;
			
			body = World.world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);	
			body.SetPosition(new b2Vec2((_x) / World.scale, (_y ) /  World.scale));
		}
		
	}

}