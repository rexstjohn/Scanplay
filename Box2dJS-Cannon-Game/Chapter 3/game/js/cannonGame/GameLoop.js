// The main loop of the game.
function GameLoop(_canvasId) {
	
	// Game loop constants.
	var IS_UPDATING          = false;
	var TIMESTEP_LENGTH      = 1.0/60;
	var ITERATIONS_PER_STEP  = 1;
	var FRAME_SKIP_TIME      = 10;
	var DRAW_WIREFRAMES      = true;
	
	// Basic world variables.
	var isRunning            = false;
	var gameObjects          = new Array();
	
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
		
		// First, clear the context to reset the graphics.
		GameResources.GameContext.clearRect(0, 0, canvasWidth, canvasHeight);
		
		// Next, update the physics world by calling "step" on it.
		GameResources.GameWorld.update(TIMESTEP_LENGTH, ITERATIONS_PER_STEP);
		
		// Now, draw the world's objects as wireframes on the context.
		if(DRAW_WIREFRAMES)
			Box2dWireFrameRenderer.drawWireFrame(GameResources.GameWorld.world, GameResources.GameContext);
			
		// Upate all the game objects.
		for (var i = 0; i < gameObjects.length; i++){
			gameObjects[i].update();
		}
	
		// Keep running the timer until told otherwise
		setTimeout('GameResources.GameLoop.update()', FRAME_SKIP_TIME);
	}

	// Add a new game object to the update loop and to the world.
	this.addGameObject = function(_gameObject){
		gameObjects.push(_gameObject);
	}
}

