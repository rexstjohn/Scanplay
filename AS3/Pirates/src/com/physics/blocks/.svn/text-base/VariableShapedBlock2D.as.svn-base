package com.physics.blocks 
{
	import flash.geom.Point;
	import com.physics.factory.PhysicsFactory
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class VariableShapedBlock2D extends PhysicsObject
	{
		
		public function VariableShapedBlock2D(_p:Point, _skin:String, _height:Number, _width:Number, _points:int, _damagedState:String = "undefined",_isStatic:Boolean = false, _health:Number = 10) 
		{						
			canBeNailed = true;
			isStatic = _isStatic;
			points = _points;
			
			//resource key for the shattered bits
			if(_damagedState == "undefined")
			{damagedState = _skin; }
			else { damagedState = _damagedState;}
			
			var obj:Object = PhysicsFactory.CreatePhysicsObject(_p, _skin, "VariableBlock2D",false,0,null, _height, _width);
			Main.m_sprite.addChild(obj["sprite"]);
			body = obj["body"];
			skin = obj["sprite"];
			
			super(true,health);
		}
		
	}

}