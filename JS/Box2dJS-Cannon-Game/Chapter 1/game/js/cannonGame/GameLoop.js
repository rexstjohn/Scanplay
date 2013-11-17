
function GameLoop(_gameWorld, _context, _canvasId) {
	
	// Game loop constants.
	var IS_UPDATING          = false;
	var TIMESTEP_LENGTH      = 1.0/60;
	var ITERATIONS_PER_STEP  = 1;
	var DRAW_WIREFRAMES      = true;
	
	// Basic world variables.
	var gameWorld 		     = _gameWorld;
	var context              = _context;
	var isRunning            = false;
	
	// Record the dimensions of the canvas context. 
	var canvasElement        = $(_canvasId);
	var canvasWidth 	     = parseInt(canvasElement.width);
	var canvasHeight 	     = parseInt(canvasElement.height);
	var canvasTop 		     = parseInt(canvasElement.style.top);
	var canvasLeft 	         = parseInt(canvasElement.style.left);
	
	// Begins the game physics and update loop.
	this.start = function (){
		
		// Start the update loop.
		isRunning = true;
		this.update();
	}
	
	// Loop through all the objects in the game and call their update() functions.
	// This is Game Loop - the core of the entire game.
	this.update = function(){
		
		if(!isRunning) return;
		
		// First, update the physics world by calling "step" on it.
		gameWorld.update(TIMESTEP_LENGTH, ITERATIONS_PER_STEP);
		
		// Next, clear the context to reset the graphics.
		context.clearRect(0, 0, canvasWidth, canvasHeight);
		
		// Now, draw the world's objects as wireframes on the context.
		if(DRAW_WIREFRAMES)
			Box2dWireFrameRenderer.drawWireFrame(gameWorld.world, context);
	
		// Keep running the timer until told otherwise
		setTimeout('gameLoop.update()', 10);
	}

	// Add a new game object to the update loop and to the world.
	this.addGameObject = function(_gameObject){

	}

	// Remove a game object from the update loop and take it out of the world.
	this.removeGameObject = function(_gameObject){

	}
}

