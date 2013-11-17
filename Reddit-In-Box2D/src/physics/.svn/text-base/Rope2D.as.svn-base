package physics
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.Joints.b2JointDef;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import flash.display.InterpolationMethod;
	import flash.geom.Point;
	import physics.PhysicsWorld;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Rope2D extends PhysicsObject
	{
		protected var segments:Array;
		
		//rope stuff
		private  var boxDef:b2PolygonShape;
		private  var bodyDef:b2BodyDef;
		private var revoluteJointDef:b2RevoluteJointDef;
		private var fixtureDef:b2FixtureDef;
		private var lastLink:b2Body;
		private var chainLink:b2Body;
		
		//chain details
		private var chainBlockWidth:Number;
		private var chainBlockHeight:Number;
		
		//anchor point
		private var anchorPoint:Point;
		
		public function Rope2D(_anchorX:Number, _anchorY:Number, _linkCount:int = 10, _linkWidth:Number = 10, _linkHeight:Number = 20) 
		{
			super();
			
			segments      = new Array();	
			anchorPoint   = new Point(_anchorX, _anchorY);
			var stat:StaticBlock2D = new StaticBlock2D(anchorPoint.x, anchorPoint.y,5,5);
			chainBlockHeight = _linkHeight;
			chainBlockWidth  = _linkWidth
			
			for (var i:int = 0; i < _linkCount; i++) 
			{				
				segments.push(new Block2D(_anchorX, _anchorY + (chainBlockHeight * i), chainBlockWidth, chainBlockHeight));
				
				if (i > 0)
				{
					// joint
					lastLink = Block2D(segments[i - 1]).GetBody();
					revoluteJointDef = new b2RevoluteJointDef();
					revoluteJointDef.Initialize(lastLink, Block2D(segments[i]).GetBody(), new b2Vec2(_anchorX/ PhysicsWorld.GetScale(), (i * (chainBlockHeight / PhysicsWorld.GetScale())) + (_anchorY / PhysicsWorld.GetScale())));
					PhysicsWorld.GetWorld().CreateJoint(revoluteJointDef);
					Block2D(segments[i - 1]).DrawSquare(_linkWidth, _linkHeight);
				}
			}
			
			lastLink = Block2D(segments[0]).GetBody();
			revoluteJointDef = new b2RevoluteJointDef();
			revoluteJointDef.Initialize(lastLink, stat.GetBody(), new b2Vec2(_anchorX/ PhysicsWorld.GetScale(), (_anchorY / PhysicsWorld.GetScale())));
			PhysicsWorld.GetWorld().CreateJoint(revoluteJointDef);
			
			AddToStage();
		}		
		
		public override function Load():void
		{
			for each(var o:Block2D in segments)
			{
				o.GetBody().SetActive(true);
				o.visible = true;
			}			
		}
		
		public override function Unload():void
		{
			for each(var o:Block2D in segments)
			{
				o.GetBody().SetActive(false);
				o.visible = false;
			}			
		}
		
		//creates the chain on stage
		public override function AddToStage():void
		{
			for each(var o:Block2D in segments)
			{
				Main.GetStage().addChild(o);
			}
		}
		
		public function AddAnchorBody(_body:b2Body):void
		{
			lastLink = Block2D(segments[segments.length - 1]).GetBody();
			revoluteJointDef = new b2RevoluteJointDef();
			revoluteJointDef.Initialize(lastLink, _body,lastLink.GetPosition());
			PhysicsWorld.GetWorld().CreateJoint(revoluteJointDef);			
		}
	}
}