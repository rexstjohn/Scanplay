package Controller 
{
	import Controller.Controller;
	import flash.errors.ScriptTimeoutError;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import Level.Battlefield;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class BattlefieldController extends Controller
	{
		public var mouseDown:Boolean = false;
		
		public function BattlefieldController(b:Battlefield) 
		{
			super();			
			battlefield = b;
			
			battlefield.addEventListener(MouseEvent.MOUSE_DOWN, handleDown);
			battlefield.addEventListener(MouseEvent.MOUSE_UP, handleUp);
			battlefield.sprite.stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			battlefield.sprite.stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
		}
		
		public function handleKeyDown(e:KeyboardEvent):void
		{
			trace(e.keyCode);
			switch(e.keyCode)
			{
				case 187:
					battlefield.scaleX -= .15;
					battlefield.scaleY += .15;
					break;
				case 189:
					battlefield.scaleX += .15;
					battlefield.scaleY -= .15;
					break;
				case 90:
					battlefield.rotation += 45;
					break;
				case 88:
					battlefield.rotation -= 45;
					break;
			}
		}
		
		public function handleKeyUp(e:KeyboardEvent):void
		{
			
		}	
		
		public function handleDown(e:MouseEvent):void
		{
			battlefield.startDrag();
		}
		
		public function handleUp(e:MouseEvent):void
		{
			battlefield.stopDrag();
		}
		
	}

}