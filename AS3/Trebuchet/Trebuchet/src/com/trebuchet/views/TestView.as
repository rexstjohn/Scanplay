package com.trebuchet.views
{
	import com.core.ui.controls.GameButton;
	import com.trebuchet.events.*;
	
	import flash.geom.Point;

	//a menu used to browse the various tests we can perform
	public class TestView extends GameViewBase
	{
		public function TestView()
		{
			super(TEST_VIEW);
			this.addChildView(new GameButton(new Point(this.center.x, this.center.y-100), "Start Test", new StartGameEvent()));
			this.addChildView(new GameButton(new Point(this.center.x, this.center.y+100), "Start Editor", new StartEditorEvent()));
		}
	}
}

