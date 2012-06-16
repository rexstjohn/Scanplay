package com.trebuchet.helpers
{
	import com.core.interfaces.IFactory;
	import com.core.mvc.ApplicationContext;
	import com.core.ui.components.ViewNavigator;
	import com.core.util.SuperSprite;
	import com.trebuchet.controllers.GameMenuViewController;
	import com.trebuchet.controllers.GameViewController;
	import com.trebuchet.models.*;
	import com.trebuchet.views.*;

	public class ApplicationContextBuilder implements IFactory
	{
		public function ApplicationContextBuilder()
		{
		}

		public static function createTestContext(_canvas:SuperSprite):ApplicationContext
		{
			var _context:ApplicationContext = new ApplicationContext(_canvas);

			//add default views
			var _navigator:ViewNavigator = new ViewNavigator(_canvas);
			_navigator.pushView(new GameView());
			_navigator.pushView(new TestView());

			//create default models
			_context.addModel(new TrebuchetModel(), GameModel.TREBUCHET_MODEL);
			_context.addModel(new GameStatsModel(), GameModel.GAME_STATS_MODEL);
			_context.addModel(new StoreModel(), GameModel.STORE_MODEL);

			_context.viewNavigator = _navigator;
			_context.addController(new GameMenuViewController(_context));
			_context.addController(new GameViewController(_context));
			return _context;
		}

		public static function createContext(_canvas:SuperSprite):ApplicationContext
		{
			var _context:ApplicationContext = new ApplicationContext(_canvas);

			//add default views
			var _navigator:ViewNavigator = new ViewNavigator(_canvas);
			_navigator.pushView(new GameView());
			_navigator.pushView(new MainMenu());
			_navigator.pushView(new OptionsMenu());
			_navigator.pushView(new GameStoreMenu());

			//create default models

			_context.viewNavigator = _navigator;
			_context.addController(new GameMenuViewController(_context));
			_context.addController(new GameViewController(_context));
			return _context;

		}
	}
}

