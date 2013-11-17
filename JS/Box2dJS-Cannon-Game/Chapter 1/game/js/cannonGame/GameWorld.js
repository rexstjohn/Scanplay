// A simple Box2D game world class.
function GameWorld() {
	
	// Some world constants
	var WORLD_WIDTH        = 2000;
	var WORLD_HEIGHT       = 2000;
	var GRAVITY            = 300;
	var WALL_WIDTH         = 10;
	
	// Some ground constants.
	var GROUND_WIDTH       = 1000;
	var GROUND_HEIGHT      = 50;
	var GROUND_X           = CANVAS_WIDTH/2;
	var GROUND_Y           = CANVAS_HEIGHT;
	var GROUND_RESTITUTION = .2;
	
	// Create our world and ground.
	this.world  = createWorld(); 
	this.ground = createGround(this.world);
	
	// Add walls to the left and right.
	createWall(this.world, 0, 125, WALL_WIDTH, CANVAS_HEIGHT);
	createWall(this.world, CANVAS_WIDTH, 125, WALL_WIDTH, CANVAS_HEIGHT);
	
	// Function for creating a physics world.
	function createWorld(){
		
		// AABB stands for "Axis Aligned Bounding Box." 
		// That is a fancy way of saying "here is my physics world and 
		// everything inside it will happen inside this specified rectangular area."
		var worldAABB = new b2AABB();

		// All the world action will happen inside these two vertices.
		worldAABB.minVertex.Set(-WORLD_WIDTH/2, -WORLD_HEIGHT/2);
		worldAABB.maxVertex.Set(WORLD_WIDTH/2, WORLD_HEIGHT/2);

		// Specify the world's gravity. If we were on the moon, we would set a low gravity. 
		// However, we will pretend we are on earth and set a relatively normal gravity.
		// It can also be fun, but not realistic, to set gravity values for 'x' instead of just 'y'
		// such as in a game where you want the player to hit a button to make gravity act sideways. 
		var gravity = new b2Vec2(0, GRAVITY); 

		// Zzzzz...The 'sleep' flag means that the world is in a sort of 'static' mode where nothing is
		// moving. Effectively, time is stopped and no physics object in the world will react to any
		// forces. You can flip the sleep property on and off to pause or start physics if the player
		// is doing something like viewing the main menu, for example.
		var doSleep = true; 

		// Create the world by feeding in all the necessary properties and settings: The rectangle where
		// we want the game physics to occur, the gravity in that world and whether or not that world is
		// running.
		var newWorld = new b2World(worldAABB, gravity, doSleep);
		return newWorld;
	}
	
	// Function for creating the ground body in our physics world.
	function createGround(_world) {
		
		// A Box Def or Box Definition is used when we wish to create a physics body that is rectangular.
		// It is like an adjective or set of adjectives which describe the physics body we want, what shape
		// it should be and how wide and tall we want it. It must be added to a body definition to have any
		// meaning in our game. Here we declare we want a "ground" box with a certain width and height.
		var groundBoxDef = new b2BoxDef();
		groundBoxDef.extents.Set(GROUND_WIDTH, GROUND_HEIGHT);
		
		// Restitution is an extremely fancy word for "how bouncy is this object."
		// An object with a large restitution will bounce around like a superball. 
		// An object with a low restitution will not bounce or reflect incoming forces at all.
		// Again, we are applying descriptive adjectives to the rectangle box before creating our body.
		// A "restitution" of "1" means that this body perfectly reflects all forces applied to it.
		// A "restitution" of ".2" means that only 20% of the force applied to the body is bounced back.
		groundBoxDef.restitution = GROUND_RESTITUTION;
		
		// Here is where the body actually comes to life. We create a generic physics body and then,
		// by adding the BoxDef shape to it, turn it into a real physics box we can play with. 
		var groundBody = new b2BodyDef();
		groundBody.AddShape(groundBoxDef);
		groundBody.position.Set(GROUND_X, GROUND_Y);
		
		// Tell the physics world that we want to create the ground body and add it to the scene.
		return _world.CreateBody(groundBody)
	}
	
	// Create walls for the game objects to sit inside.
	function createWall(_world, _x, _y, _width, _height) {
		
		// Nothing new here, pretty much the same as making the grounds
		var boxDef = new b2BoxDef();
		
		boxDef.extents.Set(_width, _height);
		
		var boxBody = new b2BodyDef();
		boxBody.AddShape(boxDef);
		boxBody.position.Set(_x,_y);
		
		return _world.CreateBody(boxBody);
	}
	
	// Called every frame to update the game world.
	this.update = function(_timeStepLength,_iterationsPerSecond){
	
		// Tells the game to update one physics step.
		this.world.Step(_timeStepLength, _iterationsPerSecond);
	}
}