// A cannonball.
function CannonBall(_x,_y,_radius,_imageURL, _id){
	
	// Define the body of our cannonball.
	this.body = PhysicsUtils.CreateDynamicCircle(GameResources.GameWorld.world,_x,_y,_radius);
	this.radius = _radius;
	this.id = this.body.userData = _id;
	this.type = 'cannon_ball';
	this.isDestroyed = false;
	
	// Load the skin image.
    var skin = new Image();
    skin.src = _imageURL;
	
	// The update function used to bind the skin graphic for this object to it's physical location and rotation.
	this.update = function(){
		PhysicsUtils.BindGraphicToBox2DBody(this.body,skin, this.radius,this.radius);
	}
	
	// Fire the cannonball.
	this.applyImpulse = function(_angle,_force, _startingPosition){
		
		this.body.ApplyImpulse(new b2Vec2(Math.cos(_angle * (Math.PI / 180)) * _force,
		                                 Math.sin(_angle * (Math.PI / 180)) * _force),
		                                 _startingPosition);
	}
	
	this.handleCollission = function(_entity){
		//Nothing to see here.
	}
}