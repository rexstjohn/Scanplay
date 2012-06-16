package {
	import com.core.interfaces.*;
	import com.core.mvc.ApplicationContext;
	import com.core.mvc.EventBus;
	import com.core.util.SuperSprite;
	import com.trebuchet.config.GameConfig;
	import com.trebuchet.controllers.*;
	import com.trebuchet.helpers.ApplicationContextBuilder;
	import com.trebuchet.views.*;

	[SWF(width="800", height="600", frameRate="30", backgroundColor="#000000")]
	public class main extends SuperSprite implements IObserver
	{
		//the application context
		private var _context:ApplicationContext;

		// test the application
		private var _isTest:Boolean = true;

		public function main()
		{
			EventBus.instance.subscribe(this);
			this.fill(GameConfig.STAGE_WIDTH,GameConfig.STAGE_HEIGHT,0x0000000,.1);

			//if test, run the test else run the game
			(_isTest)?startTestMode():startGameMode();
		}

		private function startTestMode():void
		{
			//initialize the context
			_context = ApplicationContextBuilder.createTestContext(this);

			//load the first view
			_context.navigateToView(GameViewBase.TEST_VIEW);
		}

		private function startGameMode():void
		{
			//initialize the context
			_context = ApplicationContextBuilder.createContext(this);

			//load the first view
			_context.navigateToView(GameViewBase.MAIN_MENU_VIEW);
		}

		//IObserver methods
		public function update(e:IEvent):void{}
		public function notify(e:IEvent):void{}
		public function unsubscribe():void{EventBus.instance.unsubscribe(this);}
	}
}


