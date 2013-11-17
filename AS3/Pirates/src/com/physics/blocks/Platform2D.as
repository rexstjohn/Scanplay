package com.physics.blocks 
{
	import Box2D.Common.Math.b2Vec2;
	import com.physics.GameWorld;
	import com.physics.factory.PhysicsFactory
	import com.core.util.Utilities;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Platform2D extends PhysicsObject
	{		
		//member vars
		protected var vertices:Array;
		
		public function Platform2D(_p:Point, _p2:Point, _skin:String,  _damagedState:String = "undefined", _isStatic:Boolean = false , _health:Number  = 10, _points:int = 50) 
		{		
			
			super(true, _health);	
			vertices = new Array();
			vertices.push(_p);
			vertices.push(_p2);		
			isStatic = _isStatic;	
			points = _points;
			
			//resource key for the shattered bits
			if(_damagedState == "undefined")
			{damagedState = _skin; }
			else { damagedState = _damagedState;}			
			
			var obj:Object = PhysicsFactory.CreatePhysicsObject(null, _skin, "Platform2D", isStatic, 0, vertices);
			body = obj["body"];
			skin = obj["sprite"];				
				
			Main.m_sprite.addChild(skin);	
		}				
		
		protected override function Update(e:Event):void
		{
			skin.x = ( body.GetPosition().x * GameWorld.pixels_per_meter);
			skin.y = ( body.GetPosition().y * GameWorld.pixels_per_meter );
			
			skin.rotation =  (body.GetAngle() * ( 180 / Math.PI)) + 90;
		}	
		
		public function CreateDepth():void
		{
			skin.filters = [new DropShadowFilter(3, -10, 0x000000, .15,2,2,1,1)];
		}
		
	}
}