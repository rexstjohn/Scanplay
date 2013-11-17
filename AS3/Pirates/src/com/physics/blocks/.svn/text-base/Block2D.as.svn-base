package com.physics.blocks 
{
	import flash.geom.Point;
	import com.physics.factory.PhysicsFactory
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Block2D extends PhysicsObject
	{		
		public function Block2D(_p:Point, _skin:String, _points:int = 25, _damagedState:String = "undefined",_isStatic:Boolean = false, _health:Number = 10) 
		{						
			canBeNailed = true;
			isStatic = _isStatic;
			points = _points;
			
			//resource key for the shattered bits
			if(_damagedState == "undefined")
			{damagedState = _skin; }
			else { damagedState = _damagedState;}
			
			var obj:Object = PhysicsFactory.CreatePhysicsObject(_p, _skin, "Block2D");
			Main.m_sprite.addChild(obj["sprite"]);
			body = obj["body"];
			skin = obj["sprite"];
			
			super(true,health);
		}		
	}
}