package com.scanplay.physics 
{
	import flash.geom.Point;
	import GameObjects.FindIt;
	import flash.events.*;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class Physics
	{
		private var obj:FindIt;
		public var mass:Number;
		public var force:Point;
		public var gravity:Number = 10;
		public var terminalVelocity:Number = 10;
		public var bounce:Number = .5;
		public var paused:Boolean =  false;
		
		//world constraints
		public var worldFloor:Number;
		public var gameWidth:Number = 500;
		
		public function Physics(o:FindIt) 
		{
			obj = o;
			mass = obj.height * obj.width;
			force = new Point(0, 0);
		}
		
		public function start():void
		{			
			worldFloor = obj.sprite.stage.stageHeight - 50;			
			//obj.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void
		{
			if (!paused)
			{
				//if we are close to the ground, we are at rest			
				//handle gravity
				if(force.y <= terminalVelocity)
				force.y += gravity / (mass / 600);
				
				//check if we are bouncing off the floor
				if (obj.y >= worldFloor)
				{
					handleBounce();
				}				
	
				if((obj.x + force.x <= gameWidth) && (obj.x + force.x >= 0))
				obj.x += force.x; 
				
				obj.y += force.y;				
			}
		}
		
		private function normalizeCenterOfGravity():void
		{
			
		}
		
		private function handleBounce():void
		{
			force.y = -1 * force.y * bounce;
			force.x = -1 * force.x * bounce;
		}
	}

}