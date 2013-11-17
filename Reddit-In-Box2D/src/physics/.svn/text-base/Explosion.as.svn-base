package physics
{
	import Box2D.Common.Math.b2Vec2;
	import physics.Block2D;
	import Box2D.Dynamics.b2Body;
	import Utils;
	import physics.PhysicsWorld;
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * Physics based sprite explosion
	 */
	public class Explosion
	{
		private var particles:Array;
		private var xNeg:int = 1;
		private var yNeg:int = 1;
		
		public function Explosion(_x:Number, _y:Number,_particleCount:int = 6) 
		{
			particles = new Array();
			
			for (var g:int = 0; g < _particleCount; g++)
			{
				if (Utils.GetRandomNumberInARange(100, 0) > 50)
				xNeg = -1;
				else 
				xNeg = 1;
				
				if (Utils.GetRandomNumberInARange(100, 0) > 50)
				yNeg = -1;
				else 
				yNeg = 1;
				
				particles.push(new Block2D(_x, _y,  Utils.GetRandomNumberInARange(10,2), Utils.GetRandomNumberInARange(10,2)));
				b2Body(particles[particles.length - 1].GetBody()).ApplyImpulse(new b2Vec2(xNeg * Utils.GetRandomNumberInARange(3,1), yNeg * Utils.GetRandomNumberInARange(3,1)), new b2Vec2(_x / PhysicsWorld.GetScale(), _y / PhysicsWorld.GetScale()));
				Main.GetStage().addChild(particles[g]);
			}
		}		
	}
}