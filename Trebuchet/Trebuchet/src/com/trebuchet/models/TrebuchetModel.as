package com.trebuchet.models
{
	import com.core.mvc.Model;
	import com.trebuchet.config.TrebuchetConfig;

	//singleton game model used to represent the state of the current game level
	public class TrebuchetModel extends Model
	{
		//states
		public static const IDLE_STATE:String     = "idle";
		public static const FIRING_STATE:String   = "firing";
		public static const LAUNCHED_STATE:String = "launched";

		//
		private var _state:String;
		private var _ammo:Array; //number of shots we have left

		//characteristics
		public var height:int =        TrebuchetConfig.DEFAULT_HEIGHT; //how tall the trebuchet is off the ground
		public var ammoCapacity:int =  TrebuchetConfig.DEFAULT_AMMO_CAPACITY; //how much ammo the trebuchet carries at the start
		public var armLength:int =     TrebuchetConfig.DEFAULT_ARM_LENGTH; //how long the throwing arm is by default
		public var ropeLength:int =    TrebuchetConfig.DEFAULT_ROPE_LENGTH; //how long the throwing rope is
		public var payloadWeight:int = TrebuchetConfig.DEFAULT_PAYLOAD_WEIGHT; //how much the payload weighs when it drops
		public var ammoType:String =   TrebuchetConfig.DEFAULT_AMMO_TYPE;//type of ammo we are firing

		public function TrebuchetModel()
		{
			_state=IDLE_STATE;
			_ammo = new Array();
		}

		public function set state(_state:String):void
		{
			this._state = _state;
		}

		public function get state():String
		{
			return _state;
		}

		public function shotsLeft():int
		{
			return _ammo.length;
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

