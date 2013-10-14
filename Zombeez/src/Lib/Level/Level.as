package Lib.Level 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Lib.GameEvent.LevelEvent;
	import Lib.GameObject;
	
	/**
	 * ...
	 * @author Rex
	 */
	public class Level extends GameObject
	{
		public var levelNumber:int;
		public var backgroundName:String;
		public var creatureCount:int;
		public var maxCreatureLevel:int; //highest level of creature we allow to be spawned
		
		public function Level() 
		{
			super("Level");	
		}		
		
		public function init(zCount:int, bg:String, mcl:int):void
		{			
			Name = name;
			buttonMode = true;
			
			creatureCount = zCount;
			maxCreatureLevel = mcl;
			backgroundName = bg;
			
			//set the level number
			 var myPattern:RegExp = /Level/;  
			levelNumber = int(Name.replace(myPattern, "")); 			
			
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(Event.ENTER_FRAME, onEnter);
			addEventListener(MouseEvent.MOUSE_OUT, onOut);
			addEventListener(MouseEvent.MOUSE_OVER, onOver);
		}
		
		public function onEnter(e:Event):void
		{
			if (currentLabel == "Finished")
			{
				stop();
			}
		}
		
		public function onClick(e:MouseEvent):void
		{			
			Update("LoadLevel");		
		}
		
		public function onOver(e:MouseEvent):void 
		{
			//glowRed();			
		}
		
		public function onOut(e:MouseEvent):void
		{
		//	filters = [];
		}
		
		public function Update(c:String):void
		{
			var g:LevelEvent = new LevelEvent("LoadLevel", this);
			d.dispatchEvent(g);
		}
		
	}
}