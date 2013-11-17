package com.physics.blocks 
{
	import com.core.GameLevel;
	import com.physics.factory.PhysicsFactory;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Circle2D extends PhysicsObject
	{		
		public function Circle2D(_p:Point, _skin:String, _radius:Number, _damagedState:String = "undefined",_isStatic:Boolean = false) 
		{						
			super();
			isStatic = _isStatic;
			
			//resource key for the shattered bits
			if(_damagedState == "undefined")
			{damagedState = _skin; }
			else { damagedState = _damagedState;}
			
			var obj:Object = PhysicsFactory.CreatePhysicsObject(_p, _skin, "Circl2D",false,_radius);
			Main.m_sprite.addChild(obj["sprite"]);
			body = obj["body"];
			skin = obj["sprite"];	
			GameLevel.AddObject(this);		
		}		
	}
}