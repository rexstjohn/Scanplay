// Constants.
var CANVAS_ID 	  = 'canvas';
var CANVAS_WIDTH  = 800;
var CANVAS_HEIGHT = 600;

// A general purpose object we can use to share shared game resources.
function GameResources(){}

// Some IO basics
GameResources.Mouse = function(){
	this.x =0;
	this.y =0;
}

// When the web page has finished loading, begin the game simulation.
Event.observe(window, 'load', function() {
	
	// Fetch the "canvas" element and save it to a var for later use.
	GameResources.GameContext	= $(CANVAS_ID).getContext('2d');
	GameResources.GameContext.height = CANVAS_HEIGHT;
	GameResources.GameContext.width  = CANVAS_WIDTH;

	// Listen for mouse movement updates.
	Event.observe(window,'mousemove',  function(e) {

		var element = Event.element(e);
		GameResources.Mouse.x = Event.pointerX(e);
		GameResources.Mouse.y = Event.pointerY(e);
	});

	// Listen for mouse clicks.
	Event.observe(window, 'click', function(e) {

		GameResources.GameLoop.handleClick(e);
	});
	
	// Create the game world (aka physics world)
	GameResources.GameWorld   = new GameWorld();
	
	// Create the game loop (used to update the game world every few fractions of a second)
	GameResources.GameLoop    = new GameLoop(CANVAS_ID);
	
	// Create a couple boxes.
	var crate = new Crate(400,100,'crateA');
	GameResources.GameLoop.addGameObject(crate);
	
	var cannon = new Cannon(70,500);
	GameResources.GameLoop.addGameObject(cannon);
	
	// Begin the game loop / physics world update loop.
	GameResources.GameLoop.start();
});

