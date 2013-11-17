// General purpose utilities for performing a range of useful physics operations.
function PhysicsUtils(){}

// Factory methods for generating dynamic boxes.
PhysicsUtils.CreateDynamicBox = function(_world,_x,_y,_width,_height){
	
	// Create the body definition for our box.
	var boxDef = new b2BoxDef();
	boxDef.extents.Set(_width,_height);
	boxDef.density = 1.0;
	boxDef.friction = 0.5;
	
	// Body for the box.
	var boxBody = new b2BodyDef();
	boxBody.AddShape(boxDef);
	boxBody.position.Set(_x,_y);
	
	return _world.CreateBody(boxBody);
}

// Factory methods for generating static boxes.
PhysicsUtils.CreateStaticBox = function(_world,_x,_y,_width,_height){

	// Create the body definition for our box.
	var boxDef = new b2BoxDef();
	boxDef.extents.Set(_width,_height);
	
	//Note: the way we tell Box2D that this shape doesn't move is to simply not sset a density.

	// Body for the box.
	var boxBody = new b2BodyDef();
	boxBody.AddShape(boxDef);
	boxBody.position.Set(_x,_y);

	return _world.CreateBody(boxBody);
}