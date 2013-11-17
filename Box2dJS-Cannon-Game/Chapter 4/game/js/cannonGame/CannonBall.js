// A cannonball.
function CannonBall(_x,_y,_radius,_imageURL){
	
	// Define the body of our cannonball.
	var body = PhysicsUtils.CreateDynamicCircle(GameResources.GameWorld.world,_x,_y,_radius);
	var radius = _radius;
	
	// Load the skin image.
    var skin = new Image();
    skin.src = _imageURL;
	
	// The update function used to bind the skin graphic for this object to it's physical location and rotation.
	this.update = function(){
		PhysicsUtils.BindGraphicToBox2DBody(body,skin, radius,radius);
	}
	
	// Fire the cannonball
	this.fire = function(_angle,_force, _startingPosition){
		
		body.ApplyImpulse(new b2Vec2(Math.cos(_angle * (Math.PI / 180)) * _force,
		                                 Math.sin(_angle * (Math.PI / 180)) * _force),
		                                 _startingPosition);
	}
}