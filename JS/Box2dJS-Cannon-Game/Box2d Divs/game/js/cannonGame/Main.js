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
	var crate = new GameBlock(400,180,250,250,  "diva");
	GameResources.GameLoop.addGameObject(crate);
	
	var crate2 = new GameBlock(200,100,50,50,"divb");
	GameResources.GameLoop.addGameObject(crate2);
	
	var crate3 = new GameBlock(300,300,150,50, "divc");
	GameResources.GameLoop.addGameObject(crate3);
	
	var crate4 = new GameBlock(400,0,25,25, "divd");
	GameResources.GameLoop.addGameObject(crate4);
	
	// Begin the game loop / physics world update loop.
	GameResources.GameLoop.start();
});


