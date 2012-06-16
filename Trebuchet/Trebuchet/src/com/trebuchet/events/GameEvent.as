package com.trebuchet.events
{
	import com.core.interfaces.IEvent;

	import flash.events.Event;

	public class GameEvent extends Event implements IEvent
	{
		/*
		 * UI EVENTS
		 *
		 */

		public static var MOUSE_CLICK:String="click";
		public static var MOUSE_DOWN:String="down";
		public static var MOUSE_UP:String="up";
		public static var MOUSE_MOVE:String="move";

		/*
		 * MENU EVENTS
		 */

		public static var LOAD_MENU_EVENT:String = "load menu";
		public static var LOAD_SCRIPTED_DIALOG_SEQUENCE_EVENT:String = "load scripted dialog sequence";
		public static var LOAD_DIALOG_EVENT:String = "load dialog";
		public static var CLOSE_DIALOG_EVENT:String = "close dialog";
		public static var LOADING_COMPLETE:String = "loading complete";
		public static var NEXT_BUTTON_EVENT:String = "next button was clicked";

		/*
		 * STORE EVENTS
		 */

		public static var BOUGHT_ITEM_EVENT:String = "bought item";

		/*
		 * GAME EVENTS
		 */

		public static var START_GAME_EVENT:String = "start game";
		public static var GAME_STARTED_EVENT:String = "game started";
		public static var END_GAME_EVENT:String = "end game";
		public static var YOU_LOSE_EVENT:String = "you lose";
		public static var YOU_WIN_EVENT:String = "you win";
		public static var GAME_VIEW_CLICK:String = "game view click";

		/*
		 * GAME EVENTS
		 */

		public static var OUT_OF_AMMO_EVENT:String = "out of ammo";
		public static var DESTROYED_OBSTACLE_EVENT:String = "destroyed an obstacle";
		public static var ACHIEVEMENT_UNLOCKED_EVENT:String = "achievement unlocked";

		//trebuchet firing related events
		public static var FIRING_EVENT:String = "firing";
		public static var READY_TO_FIRE_EVENT:String = "ready to fire";
		public static var LAUNCHED_EVENT:String = "launched";
		public static var RELOADED_EVENT:String = "reload";

		public function GameEvent(type:String)
		{
			super(type, false, false);
		}
	}
}

