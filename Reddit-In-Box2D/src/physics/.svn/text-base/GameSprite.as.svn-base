package physics 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class GameSprite extends Sprite
	{		
		public function GameSprite() 
		{
			super();			
		}
		
		public function Update():void { }
		
		public function GetX():Number
		{return x; }
		
		public function SetX(_x:Number):void
		{x = _x; }
		
		public function GetY():Number
		{return y; }
		
		public function SetY(_y:Number):void
		{y = _y;}
		
		public function AddToStage():void
		{
			Main.AddChild(this);
		}
		
		public function Show():void
		{visible = true; }
		
		public function Hide():void
		{visible = false;}
		
		public function GetName():String
		{return name; }
		
		public function SetName(_name:String):void
		{name = _name; }
		
		public function GetPosition():Point
		{
			return (new Point(x, y));
		}
		
		public function RemoveFromStage():void
		{
			Main.RemoveChild(this);
		}
		
		public function SetPosition(_x:Number, _y:Number):void
		{
			x = _x;
			y = _y;
		}
		
		public function SetRotation(_a:Number):void
		{
			rotation = _a;
		}
		
		public function DrawCircle(_radius:Number):void
		{
			graphics.beginFill(0xED4102, 1);
			graphics.drawCircle(0,0,_radius);
			graphics.endFill();
		}
		
		public function DrawSquare(_width:Number, _height:Number):void
		{
			graphics.beginFill(0xED4102, 1);
			graphics.drawRect(-( _width /2), -(_height / 2), _width, _height);
			graphics.endFill();
		}
		
		public function Destroy():void
		{
			Main.RemoveChild(this);
		}
	}
}