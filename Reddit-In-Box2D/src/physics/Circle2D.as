package physics
{
	import Box2D.Collision.b2Bound;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import physics.PhysicsWorld;
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Circle2D extends PhysicsObject
	{
		//stuff for making my block
		private  var circleDef:b2CircleShape;
		private  var bodyDef:b2BodyDef;
		private  var fixtureDef:b2FixtureDef;
		
		public function Circle2D(_x:Number, _y:Number, _radius:Number = 10) 
		{
			super();		
			
			//create my block
			circleDef     = new b2CircleShape();
			bodyDef       = new b2BodyDef();
			fixtureDef    = new b2FixtureDef();

			//set the box information
			circleDef.SetRadius(_radius / PhysicsWorld.GetScale());
			bodyDef.type = b2Body.b2_dynamicBody;

			fixtureDef.shape       = circleDef;
			fixtureDef.density     = .05;
			fixtureDef.friction    = 0.3;
			fixtureDef.restitution = 0.1;
			
			DrawCircle(_radius);

			//create the body
			body = PhysicsWorld.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			body.SetPosition(new b2Vec2(_x / PhysicsWorld.GetScale(), _y / PhysicsWorld.GetScale()));
		
			//set the starting position
			x = GetBodyX();
			y = GetBodyY();
			rotation = body.GetAngle() * ( 180 / Math.PI);	
			
			PhysicsWorld.Subscribe(this);
		}	
		
		public function ApplyTexture(texture:Sprite):void
		{
			addChild(texture);
		}
		
		public override function Update():void
		{			
			x = GetBodyX();
			y = GetBodyY();
			rotation = body.GetAngle() * ( 180 / Math.PI);
		}
		
	}
}