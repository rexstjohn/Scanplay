package com.physics.blocks 
{
	import Box2D.Dynamics.b2Body;
	import com.physics.GameWorld;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import com.physics.factory.PhysicsFactory;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Nail2D extends PhysicsObject
	{		
		public var jointDef:b2RevoluteJointDef;
		public var joint:b2RevoluteJoint;
		
		public function Nail2D(_p:Point, _key:String,  _isMotor:Boolean, _isStatic:Boolean,_isClockwise:Boolean) 
		{					
			super();
			SetAsIndestructable();
			canBeNailed = false;
			isStatic = _isStatic;
			
			var obj:Object = PhysicsFactory.CreatePhysicsObject(_p, _key,"Nail2D",isStatic);			
			Main.m_sprite.addChild(obj["sprite"]);
			body = obj["body"];
			skin = obj["sprite"];		
			
			//shrink the nail
			skin.height = skin.width = 10;
			
			jointDef = new b2RevoluteJointDef();			
			
			if (_isMotor)
			{
				//if we want a motor, do this stuff
				if(_isClockwise)
				jointDef.motorSpeed = 1.0 * -Math.PI;
				else
				jointDef.motorSpeed = -1.0 * -Math.PI;
				
				jointDef.maxMotorTorque = 5000.0;
				jointDef.enableMotor = true;
			}
			Main.m_sprite.setChildIndex(skin, Main.m_sprite.numChildren - 1);
		}		
		
		protected override function Update(e:Event):void
		{
			skin.x = ( body.GetPosition().x * GameWorld.pixels_per_meter) ;
			skin.y = ( body.GetPosition().y * GameWorld.pixels_per_meter ) ;
					
		}	
		
		public function AttachObject(b:b2Body):void
		{
			jointDef.Initialize(body, b, body.GetPosition());			
			joint = GameWorld.m_world.CreateJoint(jointDef) as b2RevoluteJoint;			
			Main.m_sprite.setChildIndex(skin, Main.m_sprite.numChildren - 1);
		}
	}

}