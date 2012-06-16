package com.physics
{
	import flash.geom.Rectangle;
	
	public class PhysicsAttributes
	{
		//possible shape definitions
		public static const CIRCLE_SHAPE:String = "circle";
		public static const SQUARE_SHAPE:String = "square";
		public static const POLYGON_SHAPE:String = "polygon";
		
		//general attributes
		private var _weight:Number;
		private var _density:Number;
		private var _restitution:Number;
		private var _friction:Number;
		private var _skinName:String;
		private var _materialName:String;
		private var _isDynamic:Boolean;
		private var _bounds:Rectangle;
		private var _shape:String;
		
		public function PhysicsAttributes(_skinName:String,_matName:String,_weight:Number=1,_friction:Number=1, _density:Number=1, _rest:Number=.1,_shape:String=SQUARE_SHAPE,_dynamic:Boolean=true)
		{
			this._weight = _weight;
			this._density = _density;
			this._restitution = _restitution;
			this._skinName = _skinName;
			this._friction = _friction;
			this._materialName = _matName;
			this._isDynamic = _dynamic;
			this._shape = _shape;
		}
		
		public function set bounds(_bounds:Rectangle):void
		{
			this._bounds = _bounds;
		}
		
		public function get bounds():Rectangle{return _bounds;}
		public function get friction():Number{return _friction;}
		public function get weight():Number{return _weight;}
		public function get density():Number{return _density;}
		public function get restitution():Number{return _restitution;}
		public function get skinName():String{return _skinName;}
		public function get materialName():String{return _materialName;}
		public function get shape():String{return _shape;}
		public function get isDynamic():Boolean{return _isDynamic;}

	}
}