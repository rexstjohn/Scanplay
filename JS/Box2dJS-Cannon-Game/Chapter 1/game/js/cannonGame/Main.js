// Constants.
var CANVAS_ID 	  = "canvas";
var CANVAS_WIDTH  = 800;
var CANVAS_HEIGHT = 600;

// Primary game classes.
var gameWorld;
var gameLoop;
var gameContext;

// When the web page has finished loading, begin the game simulation.
Event.observe(window, 'load', function() {
	
	// Fetch the "canvas" element and save it to a var for later use.
	gameContext	= $(CANVAS_ID).getContext('2d');
	gameContext.height = CANVAS_HEIGHT;
	gameContext.width  = CANVAS_WIDTH;
	
	// Create the game world (aka physics world)
	gameWorld   = new GameWorld();
	
	// Create the game loop (used to update the game world every few fractions of a second)
	gameLoop    = new GameLoop(gameWorld, gameContext, CANVAS_ID);
	
	// Begin the game loop / physics world update loop.
	gameLoop.start();
});