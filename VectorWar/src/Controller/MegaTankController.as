package Controller 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import Level.Battlefield;
	import Level.Levels.GameLevel;
	import Unit.Mobile.MegaTank;
	import flash.events.*;
	import flash.display.*;
	import Controller.Controller;
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class MegaTankController extends Controller
	{
		public var unit:MegaTank
		
		//controls
		public var rightPressed:Boolean;
		public var leftPressed:Boolean;
		public var upPressed:Boolean;
		public var downPressed:Boolean;
		
		public function MegaTankController(t:MegaTank) 
		{
			unit = t;			
			level = unit.level;
			battlefield = level.battlefield;
			
			battlefield.addEventListener(MouseEvent.MOUSE_MOVE, handleMove);
			battlefield.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDowner);
			battlefield.stage.addEventListener(KeyboardEvent.KEY_UP, keyUper);
			battlefield.addEventListener(Event.ENTER_FRAME, enterFramer);
			battlefield.addEventListener(MouseEvent.CLICK, handleClick);
		}
		
		public function handleClick(e:MouseEvent):void
		{
			/*
			var t:Point = new Point(unit.Cannon.Origin1.x, unit.Cannon.Origin2.y);
			t = unit.Cannon.localToGlobal(t);		
			var p:DumbFireShell = new DumbFireShell(e.stageX, e.stageY);
			p.x = t.x;p.y = t.y;
			sprite.addChild(p);			
			
			var t2:Point = new Point(unit.Cannon.Origin2.x, unit.Cannon.Origin2.y);
			t2 = unit.Cannon.localToGlobal(t2);		
			var p2:DumbFireShell = new DumbFireShell(e.stageX, e.stageY);
			p2.x = t2.x;p2.y = t2.y;
			sprite.addChild(p2);			
			
			var t3:Point = new Point(unit.Cannon.Origin3.x, unit.Cannon.Origin3.y);
			t3 = unit.Cannon.localToGlobal(t3);		
			var p3:DumbFireShell = new DumbFireShell(e.stageX, e.stageY);
			p3.x = t3.x;p3.y = t3.y;
			sprite.addChild(p3);*/
		}		
		
		public function handleMove(e:MouseEvent):void
		{
			var dx:Number = unit.x - e.stageX;
			var dy:Number = unit.y - e.stageY;
			var angle:Number = Math.atan2(dy, dx);
			
			unit.Cannon.rotation = angle * (180 / Math.PI) - 90;
		}
		 
		public function enterFramer(e:Event):void
		{
			if (rightPressed)
			{
				leftPressed = false;
				unit.x -= unit.speed;		 
				unit.Chasis.rotation = -90;
			}		 
			if (leftPressed)
			{
				rightPressed = false;
				unit.x += unit.speed;
				unit.Chasis.rotation = 90;
			}
			if (downPressed)
			{
				upPressed = false;
				unit.y -= unit.speed;
				unit.Chasis.rotation = 0;
			}
			if (upPressed)
			{
				downPressed = false;
				unit.y += unit.speed;
				unit.Chasis.rotation = 180;
			}
			
			//check for dual presses
			if (upPressed && rightPressed)
			{unit.Chasis.rotation = -135;}
			
			if (leftPressed && upPressed)
			{unit.Chasis.rotation = 135;}
			
			if (downPressed && leftPressed)
			{unit.Chasis.rotation = 45;}
			
			if (downPressed && rightPressed)
			{unit.Chasis.rotation = -45;}
		}
		 
		 
		public function keyDowner(e:KeyboardEvent):void
		{
			var key:uint = e.keyCode;
			if (key == 65)
			{
				leftPressed = true;
			}
			if (key == 87)
			{
				upPressed = true;
			}
			if (key == 68)
			{
				rightPressed = true;
			}
			if (key == 83)
			{
				downPressed = true;
			}
		}
		public function keyUper(e:KeyboardEvent):void
		{
			var key:uint = e.keyCode;
			if (key == 65)
			{
				leftPressed = false;
			}
			if (key == 87)
			{
				upPressed = false;
			}
			if (key == 68)
			{
				rightPressed = false;
			}
			if (key == 83)
			{
				downPressed = false;
			}
		}
	}

}