package com.trebuchet.helpers
{
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.b2Body;

	import com.core.interfaces.IFactory;
	import com.core.interfaces.IPhysicsObject;
	import com.physics.PhysicsAttributes;
	import com.physics.PhysicsContext;
	import com.physics.PhysicsObject;
	import com.physics.PhysicsUtils;
	import com.trebuchet.assets.PhysicsObjectDefs;
	import com.trebuchet.config.TrebuchetConfig;
	import com.trebuchet.models.TrebuchetModel;
	import com.trebuchet.prefabs.Background;
	import com.trebuchet.prefabs.Trebuchet;

	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class GameBuilder implements IFactory
	{
		//this is used to set up a game instance and offload the initialization process of loading a game
		//into a single area
		//responsible for: Setting up (and possible destroying) a game instance
		private var _canvas:Sprite;
		private var _physicsContext:PhysicsContext;
		private var _model:PhysicsContext;
		private var _ammunitionBuilder:AmmunitionBuilder;

		public function GameBuilder(_canvas:Sprite, _physicsContext:PhysicsContext)
		{
			this._canvas = _canvas;
			this._physicsContext = _physicsContext;
			this._ammunitionBuilder = new AmmunitionBuilder(_physicsContext);
		}

		// GAME BACKGROUND BUILDER //
		public function createBackground():void
		{
			//create the background
			var background:Background = new Background();
			background.alpha = .1;
			_canvas.addChild(background); 
		}

		//generates the trebuchet object
		public function createTrebuchet(_model:TrebuchetModel,_startX:Number = 350):Trebuchet
		{
			//create the trebuchet
			var trebuchet:Trebuchet = new Trebuchet();

			//give the trebuchet some helper methods
			trebuchet.destroyJoint = _physicsContext.world.destroyJoint;
			trebuchet.destroyBody = _physicsContext.world.destroyBody;
			trebuchet.resetLatch  = resetLatch; //method for recreating the release latch
			trebuchet.addPayload = createPayload; //method for creating a new payload
			trebuchet.reset = reset; // this function is called to recreate the trebuchet from scratch on demand

			var attributes:PhysicsAttributes = PhysicsObjectDefs.WOOD_BLOCK;
			var fulcrumLocation:Point = new Point(_startX,_model.height);

			//first, create a seesaw with an anchor pin in the middle
			var throwingArmRect:Rectangle = new Rectangle(fulcrumLocation.x,fulcrumLocation.y,_model.armLength,TrebuchetConfig.THROWING_ARMY_THICKNESS);
			attributes.bounds = throwingArmRect;
			var throwingArm:PhysicsObject = _physicsContext.factory.createPhysicsObjectFromAttributes(attributes);

			//create a pin to hold the throwing arm in place
			var throwingArmAnchorBounds:Rectangle = new Rectangle(throwingArmRect.x,throwingArmRect.y,5,5);
			var throwingArmAnchor:b2Body = _physicsContext.factory.createSquareBody(throwingArmAnchorBounds,false);

			//next, create the rotation anchor
			trebuchet.throwingArmJoint = _physicsContext.factory.createAnchor(throwingArmAnchorBounds.x,throwingArmAnchorBounds.y,throwingArm.body,throwingArmAnchor);

			//next, create the payload we are throwing
			var ropeLength:int = _model.ropeLength;

			//attach the payload to the trebuchet arm using a rope
			var rope:Array = _physicsContext.factory.createRope(throwingArmRect.x - throwingArmRect.width / 2,throwingArmRect.y,ropeLength);

			//next, add a counterweight to the throwing arm
			var counterweightBounds:Rectangle = new Rectangle(throwingArmRect.x + throwingArmRect.width / 2 ,throwingArmRect.y + throwingArmRect.height / 2,TrebuchetConfig.COUNTER_WEIGHT_DIMENSIONS.height,TrebuchetConfig.COUNTER_WEIGHT_DIMENSIONS.width);
			var heavyWoodAttributes:PhysicsAttributes = PhysicsObjectDefs.HEAVY_WOOD_BLOCK;
			heavyWoodAttributes.bounds = counterweightBounds;
			var counterWeight:PhysicsObject = _physicsContext.factory.createPhysicsObjectFromAttributes(heavyWoodAttributes);

			//attach the counterweight to the trebuchet arm
			trebuchet.counterWeightJoint = _physicsContext.factory.createAnchor(counterweightBounds.x,counterweightBounds.y,counterWeight.body,throwingArm.body);

			//create the trebuchet release latch
			var trebuchetReleaseLatchBounds:Rectangle = new Rectangle(counterweightBounds.x,counterweightBounds.y - _model.height/2,5,5);
			var trebuchetReleaseLatch:b2Body = _physicsContext.factory.createSquareBody(trebuchetReleaseLatchBounds,false);

			//add the counterweight to the world
			_physicsContext.addPhysicsObject(counterWeight);
			_physicsContext.addPhysicsObject(throwingArm);

			//add child properties to the trebuchet
			trebuchet.counterWeight = counterWeight;
			trebuchet.throwingArm = throwingArm;
			trebuchet.throwingArmAnchor = throwingArmAnchor;
			trebuchet.rope = rope;
			trebuchet.latch= trebuchetReleaseLatch;

			trebuchet.loadTrebuchet(); //reloads the trebuchet and set it into the start position

			//recreate the latch
			function resetLatch(_payload:PhysicsObject):void
			{
				//move the payload to be near the release latch
				trebuchet.latchJoint = _physicsContext.factory.createAnchor(trebuchetReleaseLatchBounds.x,trebuchetReleaseLatchBounds.y,trebuchetReleaseLatch,counterWeight.body);
			}

			function createPayload():void
			{
				//use our factory to create the payload
				var payloadBounds:Rectangle = new Rectangle(throwingArmRect.x - throwingArmRect.width / 2,throwingArmRect.y + ropeLength,14,14);
				var payload:PhysicsObject = _ammunitionBuilder.createAmmunitionByType(_model.ammoType,payloadBounds);

				//attach the first end of the rope to the throwing arm
				_physicsContext.factory.createAnchor(payloadBounds.x,throwingArmRect.y,trebuchet.throwingArm.body,trebuchet.rope[0]);

				//attach the other end of the rope to the payload
				trebuchet.payloadJoint = _physicsContext.factory.createAnchor(payloadBounds.x,payloadBounds.y,payload.body,trebuchet.rope[trebuchet.rope.length-1]);
				_physicsContext.addPhysicsObject(payload);
				trebuchet.payload = payload;
			}

			//forces the trebuchet to destroy then recreate itself
			//the logistics of putting the trebuchet back into place by hand are irritating, easier to just hit the reset button on it
			function reset(_x:Number):Trebuchet
			{
				//remove all the physics object from the world
				_physicsContext.removePhysicsObject(counterWeight);
				_physicsContext.removePhysicsObject(throwingArm);
				trebuchet.removeChild(throwingArm.skin);
				trebuchet.removeChild(counterWeight.skin);

				//kill the rope
				for each(var o:b2Body in trebuchet.rope)
				{
					_physicsContext.world.destroyBody(o);
				}

				//kill the payload if it exists
				if(trebuchet.payload) 
				{
					_physicsContext.removePhysicsObject(trebuchet.payload);
					trebuchet.removeChild(trebuchet.payload.skin);
				}

				//destroy some other physics crap here
				_physicsContext.world.destroyBody(trebuchet.throwingArmAnchor);
				_physicsContext.world.destroyBody(trebuchet.latch);
				_physicsContext.world.destroyJoint(trebuchet.throwingArmJoint);

				//self destruct
				_canvas.removeChild(trebuchet);
				trebuchet = null; // trash the trebuchet

				//return a new trebuchet
				return createTrebuchet(_model,_x);
			}

			//
			_canvas.addChild(trebuchet);
			return trebuchet;
		}

		// SCENE BUILDER //
		private function createScene():void
		{
			//factory method for the scene
		}
	}
}

