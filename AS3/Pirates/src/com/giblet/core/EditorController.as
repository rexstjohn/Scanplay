package com.giblet.core 
{
	import flash.events.*;
	import flash.events.Event;
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * This mainly just handles the scrolling and panning of the screen and 
	 * constraints the dimensions.
	 */
	public class EditorController
	{
		public static var scrollLocked:Boolean;
		
		public function EditorController() 
		{
			scrollLocked = false;
			Main.m_sprite.addEventListener(Event.ENTER_FRAME, handleEnter);
		}
		
		public function destroy():void
		{
			Main.m_sprite.removeEventListener(Event.ENTER_FRAME, handleEnter);
		}
		
		private function handleEnter(e:Event):void
		{
			if (!scrollLocked)
			{
				if (Main.m_sprite.stage.mouseX > 750 &&(Main.m_sprite.x > -1800))
				{
					if(Main.m_stage.mouseY > 150)
					Main.m_sprite.x -= 10;				
				}
				
				if (Main.m_sprite.stage.mouseX < 50 && (Main.m_sprite.x < 550))
				{				
					if(Main.m_stage.mouseY > 150)
					Main.m_sprite.x += 10;
				}
			}
		}
		
	}

}