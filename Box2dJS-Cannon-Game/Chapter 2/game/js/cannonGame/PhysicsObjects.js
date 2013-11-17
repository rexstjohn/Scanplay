// The simplest 2D game shape - a 2D block attached to a physics object.
function GameBlock(_x,_y,_width, _height){
	
	// Define the body of our box.
	var body = PhysicsUtils.CreateDynamicBox(GameResources.GameWorld.world,_x,_y,_width,_height);
	
	// The update function used to bind the skin graphic for this object to it's physical location and rotation.
	this.update = function(){
		
		// Nothing to see here yet.
	}
}