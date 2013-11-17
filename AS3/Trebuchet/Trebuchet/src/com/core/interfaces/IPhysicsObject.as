package com.core.interfaces
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	public interface IPhysicsObject
	{
		//bind the skin to the body
		function updatePhysics(e:Event):void;
		function get body():b2Body;
		function get skin():Sprite;
		function get worldPosition():Point;
		function get worldVelocity():b2Vec2;
		function get x():Number;
		function get y():Number;
	}
}

