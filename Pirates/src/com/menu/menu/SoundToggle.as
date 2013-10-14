package com.menu.menu 
{
	import com.core.factory.AssetFactory;
	import com.core.GameController;
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.core.factory.SoundFactory;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class SoundToggle extends Button
	{
		public function SoundToggle(_p:Point) 
		{
			super(_p, "", "", "ToggleSound", "SoundToggleOn");
			
			button.height = 50;
			button.width  = 50
			
			button.x = _p.x;
			button.y = _p.y;
			
			button.addEventListener(MouseEvent.CLICK, handleClick);
		}		
		
		public override function destroy():void
		{
			button.removeEventListener(MouseEvent.CLICK, handleClick);
			button = null;
			text = null;
		}
		
		protected override function handleClick(e:MouseEvent):void
		{			
			SoundFactory.PlaySound("ButtonClick", false,false,.4);
			GameController.HandleEvent(command, target);
			
			if (Settings.mute)
			MovieClip(button).gotoAndStop("SoundToggleOff");
			else
			MovieClip(button).gotoAndStop("SoundToggleOn");	
		}
	}
}