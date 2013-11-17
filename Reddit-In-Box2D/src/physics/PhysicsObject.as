package physics 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class PhysicsObject extends GameSprite
	{
		protected var body:b2Body; //special body I created
		protected var material:String; //what this is made out of
		protected var type:String;    //the type identifier of this object
		protected var points:int = 100;     //how many points this is worth
		
		public function PhysicsObject() 
		{
			material = "wood";
			
			//set the type based on the class name
			var _type:String = getQualifiedClassName(this);
			_type = _type.substr(_type.search("::") + 2, _type.length - 1);
			type = _type;
		}
		
		public function GetPoints():int
		{
			return points
		}
		
		public function GetType():String
		{
			return type;
		}
		
		public function GetBody():b2Body
		{
			return body;
		}		
		
		public function GetMaterial():String
		{
			return material;
		}
		
		public override function Destroy():void
		{
			PhysicsWorld.DestroyObject(this);			
				//			Main.RemoveChild(this);
			visible = false;
		}
		
		public function GetBodyPosition():Point
		{
			return (new Point(GetBodyX(), GetBodyY()));
		}
		
		public override function SetPosition(_x:Number, _y:Number):void
		{
			body.SetPosition(new b2Vec2(_x / PhysicsWorld.GetScale(), _y / PhysicsWorld.GetScale()));
		}
		
		public function GetBodyX():Number
		{
			return (body.GetPosition().x * PhysicsWorld.GetScale());
		}
		
		public function GetBodyY():Number
		{
			return (body.GetPosition().y * PhysicsWorld.GetScale());
		}
		
		//set the x in sprite coords
		public function SetBodyX(_x:Number):void
		{
			body.SetPosition(new b2Vec2(_x / PhysicsWorld.GetScale(), body.GetPosition().y));
		}
		
		//set the y in sprite coords
		public function SetBodyY(_y:Number):void
		{
			body.SetPosition(new b2Vec2(body.GetPosition().x, _y / PhysicsWorld.GetScale()));
		}
		
		public function GetRotationInDegrees():Number
		{
			return (body.GetAngle() * (180 / Math.PI));
		}
		
		public function SetRotationInDegrees(a:Number):void
		{
			body.SetAngle(a * (Math.PI / 180));
		}
		
		public function Load():void { }
		public function Unload():void{}
		
	}
}