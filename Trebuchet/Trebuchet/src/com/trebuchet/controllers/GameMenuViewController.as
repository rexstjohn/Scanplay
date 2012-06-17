package com.trebuchet.controllers
{
	import com.core.interfaces.IEvent;
	import com.core.mvc.ApplicationContext;
	import com.core.mvc.Controller;
	import com.core.ui.components.ViewNavigator;
	import com.trebuchet.events.GameEvent;
	import com.trebuchet.models.GameStatsModel;
	import com.trebuchet.views.GameViewBase;

	public class GameMenuViewController extends Controller
	{
		public function GameMenuViewController(_context:ApplicationContext)
		{
			super(_context);
		}

		override public function update(e:IEvent):void
		{
			//react to various menu related events here
			switch(e.type)
			{
				case GameEvent.START_GAME_EVENT:
					//start the game
					_viewNavigator.navigateToView(GameViewBase.GAME_VIEW);
					break;
				case GameEvent.START_EDITOR_EVENT:
					//start the game
					_viewNavigator.navigateToView(GameViewBase.EDITOR_VIEW);
					break;
			}
		}
	}
}

