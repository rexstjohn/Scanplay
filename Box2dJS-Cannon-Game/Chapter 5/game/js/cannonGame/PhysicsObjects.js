
// The simplest 2D game shape - a 2D block attached to a physics object.
function GameBlock(_x,_y,_width, _height,_imageURL,_id){
	
	// Define the body of our box.
	this.body = PhysicsUtils.CreateDynamicBox(GameResources.GameWorld.world,_x,_y,_width,_height);
	this.id = this.body.userData = _id;
	
	// Load the skin image.
    var skin = new Image();
    skin.src = _imageURL;
	
	// The update function used to bind the skin graphic for this object to it's physical location and rotation.
	this.update = function(){
		PhysicsUtils.BindGraphicToBox2DBody(this.body,skin, _width,_height);
	}
}

// The simplest 2D game shape - a 2D circle attached to a physics object.
function GameCircle(_x,_y,_radius,_imageURL,_id){
	
	// Define the body of our circle.
	this.body = PhysicsUtils.CreateDynamicCircle(GameResources.GameWorld.world,_x,_y,_radius);
	this.id = this.body.userData = _id;
	
	var radius = _radius;
	
	// Load the skin image.
    var skin = new Image();
    skin.src = _imageURL;
	
	// The update function used to bind the skin graphic for this object to it's physical location and rotation.
	this.update = function(){
		PhysicsUtils.BindGraphicToBox2DBody(this.body,skin, radius,radius);
	}
}
