package physics 
{	
	import Box2D.Collision.b2Bound;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Common.Math.b2Vec2;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class GroundBody extends PhysicsObject
	{
		//stuff for making my block
		private  var boxDef:b2PolygonShape;
		private  var bodyDef:b2BodyDef;
		private  var fixtureDef:b2FixtureDef;
		
		//
		private var groundWidth:Number = 2500;
		
		public function GroundBody(_x:Number, _y:Number) 
		{
			super();		
			
			//create my block
			boxDef     = new b2PolygonShape();
			bodyDef    = new b2BodyDef();
			fixtureDef = new b2FixtureDef();

			//set the box information
			boxDef.SetAsBox((groundWidth / 2) /PhysicsWorld.GetScale(), 30 /PhysicsWorld.GetScale());
			bodyDef.type = b2Body.b2_staticBody;

			fixtureDef.shape       = boxDef;
			fixtureDef.density     = .05;
			fixtureDef.friction    = 0.3;
			fixtureDef.restitution = 0.4;
			
			//DrawSquare(groundWidth, 60);

			//create the body
			body = PhysicsWorld.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			body.SetPosition(new b2Vec2(_x / PhysicsWorld.GetScale(), _y / PhysicsWorld.GetScale()));
		
			//set the starting position
			x = GetBodyX();
			y = GetBodyY();
			rotation = body.GetAngle() * ( 180 / Math.PI);	
		}	
		
		public override function Update():void
		{			
			x = GetBodyX();
			y = GetBodyY();
			rotation = body.GetAngle() * ( 180 / Math.PI);
		}
	}

}