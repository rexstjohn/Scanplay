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

// Factory methods for generating dynamic circles.
PhysicsUtils.CreateDynamicCircle = function(_world,_x,_y,_radius){

	// Create the body definition for our circle.
	var circleDef = new b2CircleDef();
	circleDef.radius   = _radius;
	circleDef.density  = .1;

	// Body for the circle.
	var circleBody = new b2BodyDef();
	circleBody.AddShape(circleDef);
	circleBody.position.Set(_x,_y);

	return _world.CreateBody(circleBody);
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

// Use this to attach a 'skin' to a box2d body on every frame update.
PhysicsUtils.BindGraphicToBox2DBody = function(_body,_skin, _width,_height){
	
    // Save the context.
    GameResources.GameContext.save();

    // Translate the context to be located at the center of the target body.
    GameResources.GameContext.translate(_body.GetCenterPosition().x, _body.GetCenterPosition().y);

    // Rotate the graphic to match the 2D physics object.
    GameResources.GameContext.rotate(_body.GetRotation());

    // Translate back to the top left of our image.
    GameResources.GameContext.translate(-_body.GetCenterPosition().x, -_body.GetCenterPosition().y);

    // Draw the image at the appropriate location.
	GameResources.GameContext.drawImage(_skin, _body.GetCenterPosition().x - _width,_body.GetCenterPosition().y - _height, _width*2,_height*2);

    // Restore the context so its ready for another round.
    GameResources.GameContext.restore();
}