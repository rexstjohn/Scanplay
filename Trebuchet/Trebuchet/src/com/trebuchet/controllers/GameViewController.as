package com.trebuchet.controllers
{
	import com.core.interfaces.*;
	import com.core.mvc.ApplicationContext;
	import com.core.mvc.Controller;
	import com.physics.PhysicsContext;
	import com.trebuchet.config.GameConfig;
	import com.trebuchet.events.GameEvent;
	import com.trebuchet.helpers.GameBuilder;
	import com.trebuchet.helpers.UIBuilder;
	import com.trebuchet.models.GameModel;
	import com.trebuchet.models.TrebuchetModel;
	import com.trebuchet.prefabs.*;
	import com.trebuchet.views.GameView;
	import com.trebuchet.views.GameViewBase;

	//Responsible for: responding to important navigation events that might effect a game e.g. pausing, exiting, winning, losing a game.
	//navigating back to the main menu when a game is won / lost. Loading scripts or dialogs that go with a game screen.
	//Helped by: game factory (to create the game)
	//Manages: The game view
	public class GameViewController extends Controller
	{
		//view
		private var _view:GameView;

		//helpers
		private var _factory:GameBuilder;
		private var _physicsContext:PhysicsContext;

		//sub controllers
		private var _trebuchetController:TrebuchetController;
		private var _canvasController:CanvasController;

		public function GameViewController(_context:ApplicationContext)
		{
			super(_context);
			this._view = _viewNavigator.getViewByName(GameViewBase.GAME_VIEW) as GameView;
			this._physicsContext = new PhysicsContext(this._view, GameConfig.GAME_BOUNDS);
			this._factory = new GameBuilder(this._view, this._physicsContext);

			//create helping controllers for sub tasks
			this._trebuchetController = new TrebuchetController(_context);
			this._canvasController = new CanvasController(_context);

			// enable debug mode
			_physicsContext.debug(true); 
		}

		override public function update(e:IEvent):void
		{
			//react to various menu related events here
			switch(e.type)
			{
				/* MENU EVENTS */
				case GameEvent.LOAD_MENU_EVENT:
					break;
				case GameEvent.GAME_STARTED_EVENT:
					//run game start sequence...
					//3.2..1...go!
					UIBuilder.createCountDown(this._view, startGame);
					break;
				default:
					break;
			}
		}
		
		private function startGame():void
		{
			//start the camera
			_canvasController.init(_view);

			//create the background
			_factory.createBackground();

			//construct the level from a level model
			var _trebuchetModel:TrebuchetModel = _context.getModelByName(GameModel.TREBUCHET_MODEL) as TrebuchetModel;
			_trebuchetController.init(_factory.createTrebuchet(_trebuchetModel));

			//start the updates
			_physicsContext.start();
		}
	}
}

