// Constants.
var CANVAS_ID 	  = 'canvas';
var CANVAS_WIDTH  = 800;
var CANVAS_HEIGHT = 600;

// A general purpose object we can use to share shared game resources.
function GameResources(){}

// When the web page has finished loading, begin the game simulation.
Event.observe(window, 'load', function() {
	
	// Fetch the "canvas" element and save it to a var for later use.
	GameResources.GameContext	= $(CANVAS_ID).getContext('2d');
	GameResources.GameContext.height = CANVAS_HEIGHT;
	GameResources.GameContext.width  = CANVAS_WIDTH;
	
	// Create the game world (aka physics world)
	GameResources.GameWorld   = new GameWorld();
	
	// Create the game loop (used to update the game world every few fractions of a second)
	GameResources.GameLoop    = new GameLoop(CANVAS_ID);
	
	// Create a couple boxes.
	var crate = new GameBlock(400,100,50,50);
	GameResources.GameLoop.addGameObject(crate);
	
	var crate2 = new GameBlock(370,200,50,50);
	GameResources.GameLoop.addGameObject(crate2);
	
	// Begin the game loop / physics world update loop.
	GameResources.GameLoop.start();
});


