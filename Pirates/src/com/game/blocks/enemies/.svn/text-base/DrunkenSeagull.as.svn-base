package com.game.blocks.enemies 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2PrismaticJoint;
	import Box2D.Dynamics.Joints.b2PrismaticJointDef;
	import com.core.factory.AssetFactory;
	import com.game.ship.weapon.Weapon;
	import com.physics.blocks.Block2D;
	import com.physics.blocks.PhysicsObject;
	import com.physics.blocks.VariableShapedBlock2D;
	import flash.geom.Point;	
	import com.core.factory.SoundFactory;
	import com.game.fx.Explosion;
	import com.physics.blocks.Block2D;
	import com.game.fx.Smoke;
	import com.game.ship.weapon.CannonBall;
	import com.physics.blocks.VariableShapedBlock2D;
	import com.physics.GameWorld;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import com.core.GameLevel;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class DrunkenSeagull extends VariableShapedBlock2D
	{
		private var the_prism_joint:b2PrismaticJointDef
		private var joint_added:b2PrismaticJoint;
		private var startY:Number;
		private var range:Number;
		
		public function DrunkenSeagull(_p:Point) 
		{
			super(_p, "DrunkenSeagull", 80, 80,150, "Coin",false,5);
			
			startY = _p.y;
			range = 100;
			
			the_prism_joint = new b2PrismaticJointDef();
			the_prism_joint.Initialize(GameWorld.m_world.GetGroundBody(), body, new b2Vec2(8.5,5),new b2Vec2(0,1));
			the_prism_joint.lowerTranslation = -range / GameWorld.pixels_per_meter;
			the_prism_joint.upperTranslation = range / GameWorld.pixels_per_meter;
			the_prism_joint.enableLimit      = true;
			the_prism_joint.maxMotorForce    = 100;
			the_prism_joint.motorSpeed       = -2.0;
			the_prism_joint.enableMotor      = true;
			joint_added=GameWorld.m_world.CreateJoint(the_prism_joint) as b2PrismaticJoint;
		}			
		
		public override function handleCollission(o:PhysicsObject, force:Number):void
		{ 
			if (o is Weapon)
			{
				Damage(health);			
			}			
			else
			Damage(force);
		}

		public override function Damage(damage:Number):void
		{
			if (!isDead)
			{
				health -= damage;
				
				if (health <= 0 && IsAlive())
				{			
					GameLevel.CompleteObjective("SeagullKilled");
					SoundFactory.PlaySound("Seagull");
					SoundFactory.PlaySound("TreasureOpen");
					var s:Smoke = new Smoke(GetPosition());			
					Destroy();
				}
			}
		}
		
		protected override function Update(e:Event):void
		{
			skin.x = ( body.GetPosition().x * GameWorld.pixels_per_meter);
			skin.y = ( body.GetPosition().y * GameWorld.pixels_per_meter ) - 15;
			
			if (skin.y >= (startY - range - 5) && skin.y <= (startY + range - 5))
			joint_added.SetMotorSpeed(2);
			else
			joint_added.SetMotorSpeed(-2);
			
			if (skin.mouseEnabled)
			skin.mouseEnabled = false;
		}		
		
	}
}