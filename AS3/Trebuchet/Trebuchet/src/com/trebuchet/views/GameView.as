package com.trebuchet.views
{
	import com.trebuchet.config.GameConfig;
	import com.trebuchet.events.GameStartedEvent;
	import com.trebuchet.events.GameViewClick;
	
	import flash.events.MouseEvent;

	public class GameView extends GameViewBase
	{
		public function GameView()
		{
			super(GameViewBase.GAME_VIEW);
		}

		//IInteractive functions
		override public function handleClick(e:MouseEvent):void
		{
			this.notify(new GameViewClick());
		}

		//IView methods
		override public function load():void
		{
			//Inform my controller that I have finished being loaded and added to the stage
			this.notify(new GameStartedEvent());
		}

		public function onPause():void{}
		public function onResume():void{}
	}
}

