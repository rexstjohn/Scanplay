package com.trebuchet.prefabs
{
	import com.core.interfaces.IEvent;
	import com.core.interfaces.IObserver;
	import com.core.mvc.EventBus;
	import com.trebuchet.assets.Library;
	import com.trebuchet.config.GameConfig;
	import com.trebuchet.events.GameEvent;
	
	import flash.display.Sprite;

	public class Background extends Sprite implements IObserver
	{	
		//states
		public static const PANNING:String="panning";
		public static const IDLE:String="idle";
		public static const RETURNING:String="returning";
		
		//current state of our background
		private var _state:String=IDLE;
		
		public function Background()
		{
			super();
			
			//add a background element
			var bg:Sprite = Library.createAsset(Library.COUNTRY_BG);
			bg.x=0;
			bg.y=0;
			bg.height=GameConfig.STAGE_HEIGHT;
			addChild(bg);
			EventBus.instance.subscribe(this);
		}
		
		//IObserver stuff
		public function notify(e:IEvent):void
		{
			EventBus.instance.notify(e);
		}
		
		public function unsubscribe():void
		{
			EventBus.instance.unsubscribe(this);
		}
		
		public function update(e:IEvent):void
		{
			switch(e.type)
			{
				case GameEvent.GAME_VIEW_CLICK:
					//deals with the user clicking on the view, generally firing a shot
					scroll();
					break;
				default:
					break;
			}
		}
		
		// scroll the background
		private function scroll():void
		{
			switch(_state)
			{
				case IDLE:
					_state = PANNING;
					break;
				case PANNING:
					_state = RETURNING;
					break;
				case RETURNING:
					break;
			}
		}
	}
}