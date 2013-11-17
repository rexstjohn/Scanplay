package com.trebuchet.helpers
{
	import com.core.ui.controls.SuperTextField;
	import com.core.util.SuperSprite;
	import com.trebuchet.config.GameConfig;

	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.Timer;

	public class UIBuilder
	{
		public function UIBuilder()
		{
		}

		public static function createBlockingMessage(_canvas:SuperSprite, callback:Function):void
		{

		}

		//generic timeout controller
		private static const timerInterval:int = 500;
		private static const countdownLength:int = 3;

		public static function createCountDown(_canvas:SuperSprite, callback:Function):void
		{
			var text:SuperTextField = new SuperTextField();
			var increment:int = countdownLength;
			text.text = String(increment);
			text.textColor = 0xFF0000;

			//add em
			_canvas.mouseEnabled = false;
			_canvas.mouseChildren=false;

			//position
			_canvas.addChild(text);
			_canvas.outline();
			text.centerTextInContainer(_canvas);

			var t:Timer = new Timer(timerInterval);
			t.addEventListener(TimerEvent.TIMER,handleTimer);
			t.start();

			function handleTimer(e:TimerEvent):void
			{
				if(increment < 0)
				{

					t.stop();
					_canvas.removeChild(text);

					t = null;
					text = null;
					_canvas.mouseEnabled = true;
					_canvas.mouseChildren=true;

					callback();
					return;
				}

				if(increment > 0)
					text.text = String(increment);
				else
					text.text = "Begin!";

				increment--;
			}
		}

	}
}

