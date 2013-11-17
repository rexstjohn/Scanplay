// The simplest 2D game shape - a 2D block attached to a physics object.
function GameBlock(_x,_y,_width, _height,_imageURL){
	
	// Define the body of our box.
	var body = PhysicsUtils.CreateDynamicBox(GameResources.GameWorld.world,_x,_y,_width,_height);
	
	// Load the skin image.
    var skin = new Image();
    skin.src = _imageURL;
	
	// The update function used to bind the skin graphic for this object to it's physical location and rotation.
	this.update = function(){
		PhysicsUtils.BindGraphicToBox2DBody(body,skin, _width,_height);
	}
}

// The simplest 2D game shape - a 2D circle attached to a physics object.
function GameCircle(_x,_y,_radius,_imageURL){
	
	// Define the body of our circle.
	var body = PhysicsUtils.CreateDynamicCircle(GameResources.GameWorld.world,_x,_y,_radius);
	
	// Load the skin image.
    var skin = new Image();
    skin.src = _imageURL;
	
	// The update function used to bind the skin graphic for this object to it's physical location and rotation.
	this.update = function(){
		PhysicsUtils.BindGraphicToBox2DBody(body,skin, _width,_height);
	}
}