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
				case GameEvent.LOAD_MENU_EVENT:
					break;
				case GameEvent.LOAD_DIALOG_EVENT:
					break;
				case GameEvent.CLOSE_DIALOG_EVENT:
					break;
				case GameEvent.NEXT_BUTTON_EVENT:
					break;
				case GameEvent.LOADING_COMPLETE:
					break;
				case GameEvent.LOAD_SCRIPTED_DIALOG_SEQUENCE_EVENT:
					break;
				case GameEvent.START_GAME_EVENT:
					//start the game
					_viewNavigator.navigateToView(GameViewBase.GAME_VIEW);
					break;
			}
		}
	}
}

