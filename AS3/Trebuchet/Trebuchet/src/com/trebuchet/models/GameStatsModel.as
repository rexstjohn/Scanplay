package com.trebuchet.models
{
	import com.core.mvc.Model;

	public class GameStatsModel extends Model
	{

		//everything we need to capture the state of the game
		private var _high_score:int;
		private var _player_name:String;
		private var _levels_played:int;
		private var _purchases:Array;
		private var _shots_fired:int;
		private var _obstacles_destroyed:int;
		private var _gold:int;
		private var _achievements_unlocked:Array;
		private var _games_played:int;
		private var _time_played:int;

		public function GameStatsModel()
		{
		}

		//save data to local store
		override public function save():void
		{}

		//load a model
		override public function load():void
		{}

		//clear the game model (delete all)
		override public function clear():void
		{}
	}
}

