package Controller 
{
	import Controller.Controller;
	import flash.events.Event;
	import Projectile.DumbFireShell;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class DumbFireShellController extends Controller
	{
		public var p:DumbFireShell;
		
		public function DumbFireShellController(pp:DumbFireShell) 
		{
			super();
			p  = pp;
			
			p.addEventListener(Event.ENTER_FRAME, handleEnter);
		}
		
		public function handleEnter(e:Event):void 
		{
			var dx:Number = p.x - p.target.x;
			var dy:Number = p.y - p.target.y;
			var distance:Number = Math.sqrt(dx * dx + dy * dy);
			var angle:Number = Math.atan2(dx, dy);
			
			if (distance > 3)
			{
				p.x += p.speed * -Math.sin(angle);
				p.y += p.speed * -Math.cos(angle);
			}
			else
			{
				if (p.parent)
				{
					p.parent.removeChild(p);
				}
			}
		
		}
	}

}