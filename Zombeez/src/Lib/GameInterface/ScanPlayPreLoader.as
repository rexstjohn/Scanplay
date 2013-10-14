package Lib.GameInterface 
{
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Lib.Game.Creature.Barista;
	import Lib.GameInterface.GameInterface;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class ScanPlayPreLoader extends GameInterface
	{
		public var StartGame:SimpleButton;
		
		public function ScanPlayPreLoader() 
		{
			super();
		}
		
		public function init():void
		{
			Name = "ScanPlayPreLoader";
			StartGame.addEventListener(MouseEvent.CLICK, onClick);
			
			var barista:Barista = new Barista();
			addChild(barista);
			barista.x = 600;
			barista.y = 400;
			barista.HealthBar.visible = false;			
			barista.init();		
			
			addEventListener(Event.ENTER_FRAME, onEnter);
			
			function onEnter(e:Event):void
			{
				if (barista.x <= 0)
				{
					removeChild(barista);
					removeEventListener(Event.ENTER_FRAME, onEnter);
				}
			}
		}
		
		public function onClick(e:MouseEvent):void
		{	
			sf.playSound("ClickSound");		
			Update("LoadMap");
		}
		
	}

}