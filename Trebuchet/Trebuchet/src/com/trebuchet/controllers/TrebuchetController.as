package com.trebuchet.controllers
{
	import com.core.interfaces.IEvent;
	import com.core.interfaces.IPhysicsObject;
	import com.core.mvc.ApplicationContext;
	import com.core.mvc.Controller;
	import com.core.ui.components.ViewNavigator;
	import com.physics.PhysicsObject;
	import com.trebuchet.events.FiringEvent;
	import com.trebuchet.events.GameEvent;
	import com.trebuchet.events.LaunchedEvent;
	import com.trebuchet.events.ReadyToFireEvent;
	import com.trebuchet.events.ReloadedEvent;
	import com.trebuchet.models.TrebuchetModel;
	import com.trebuchet.prefabs.Trebuchet;

	public class TrebuchetController extends Controller
	{
		//view / aka trebuchet
		private var _trebuchet:Trebuchet;
		private var _lastShot:IPhysicsObject; //the last shot that was fired

		//model
		private var _model:TrebuchetModel;

		public function TrebuchetController(_context:ApplicationContext)
		{
			super(_context);
		}

		public function init(_trebuchet:Trebuchet):void
		{
			this._trebuchet = _trebuchet;
			this._model = new TrebuchetModel();
		}

		override public function update(e:IEvent):void
		{
			//react to various menu related events here
			switch(e.type)
			{
				/* TREBUCHET EVENTS */
				case GameEvent.OUT_OF_AMMO_EVENT:
					break;
				case GameEvent.READY_TO_FIRE_EVENT:
					_lastShot = _trebuchet.payload;
					_trebuchet = _trebuchet.resetTrebuchet(_lastShot.x);
					this.notify(new ReloadedEvent(_lastShot,_trebuchet));
					break;
				case GameEvent.RELOADED_EVENT:
					break;
				case GameEvent.FIRING_EVENT:
					_trebuchet.releaseLatch();
					break;
				case GameEvent.LAUNCHED_EVENT:
					_trebuchet.releasePayload();
					break;
				case GameEvent.MOUSE_CLICK:
					handleClick(e);
					break;
				default:
					break;
			}
		}

		private function handleClick(e:IEvent):void
		{
			switch(_model.state)
			{
				case TrebuchetModel.IDLE_STATE:
					_model.state = TrebuchetModel.FIRING_STATE;
					this.notify(new FiringEvent(_trebuchet.payload,_trebuchet));
					break;
				case TrebuchetModel.FIRING_STATE:
					_model.state = TrebuchetModel.LAUNCHED_STATE;
					this.notify(new LaunchedEvent(_trebuchet.payload,_trebuchet));
					break;
				case TrebuchetModel.LAUNCHED_STATE:
					_model.state = TrebuchetModel.IDLE_STATE;
					this.notify(new ReadyToFireEvent(_trebuchet));
					break;
				default:
					break;
			}
		}
	}
}

