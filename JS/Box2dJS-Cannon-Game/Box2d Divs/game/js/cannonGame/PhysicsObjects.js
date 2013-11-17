// The simplest 2D game shape - a 2D block attached to a physics object.
function GameBlock(_x,_y,_width, _height, _divid){
	
	// Define the body of our box.
	var body = PhysicsUtils.CreateDynamicBox(GameResources.GameWorld.world,_x,_y,_width/2,_height/2);
	

	// Attach the associated div.
	var divid = _divid;
	var div = document.getElementById(divid);
	div.style.position = "absolute";
	div.height = _height;
	div.width=_width;
	div.style.width = _width  + "px";
	div.style.height = _height + "px";
	
	var x =  body.GetCenterPosition().x;
	var y =  body.GetCenterPosition().y;
	var rotation = body.GetRotation();
	
	// The update function used to bind the skin graphic for this object to it's physical location and rotation.
	this.update = function(){
		
		// update
		x =  body.GetCenterPosition().x;
		y =  body.GetCenterPosition().y;
		rotation = body.GetRotation();
		
		// Matrix math is fun!
		Firmin.matrix(div, [Math.cos(rotation), Math.sin(rotation),-Math.sin(rotation),Math.cos(rotation),x -( div.width/2 ),y - (div.height/2)]);
	}
}