package com.trebuchet.views
{
	import com.trebuchet.events.StartGameEvent;
	import com.core.ui.controls.GameButton;

	import flash.geom.Point;

	//a menu used to browse the various tests we can perform
	public class TestView extends GameViewBase
	{
		public function TestView()
		{
			super(TEST_VIEW);
			this.addChildView(new GameButton(this.center, "Start Test", new StartGameEvent()));
		}
	}
}

