// The cannon for our game.
function Cannon(_x,_y){
	
	// Art assets.
	var CANNON_BARREL_IMAGE_URL = 'assets/art/cannon_barrel.png';
	var CANNON_BLOCK_IMAGE_URL = 'assets/art/cannon_block.png';
	var CANNON_BALL_IMAGE_URL = 'assets/art/cannon_ball.png';
	
	// Cannon positioning and sizing.
	var CANNON_HEIGHT = 100;
	var CANNON_WIDTH  = 100;
	var CANNON_BLOCK_HEIGHT = 60;
	var CANNON_BLOCK_WIDTH  = 60;
	var ANGLE_OFFSET = 14
	var CANNON_BALL_RADIUS = 18;
	var CANNON_BALL_FORCE = 70000;
	
	// Location of the cannon's rotation axis.
	var cannonXOffset = .45 * CANNON_WIDTH;
	var cannonYOffset = .6 * CANNON_HEIGHT;
	var cannonBlockXOffset = .25 * CANNON_WIDTH;
	var cannonBlockYOffset = .15 * CANNON_HEIGHT;
	
	// Cannon vars.
	this.x = _x;
	this.y = _y;
	this.rotation = 0;
	this.shotsFired = 0;
	
	// Image components of the cannon.
    var cannonBarrelImg 	 = new Image();
    cannonBarrelImg.src		 = CANNON_BARREL_IMAGE_URL;

    var cannonBarrelBlockImg = new Image();
    cannonBarrelBlockImg.src = CANNON_BLOCK_IMAGE_URL;
	
	this.update = function(){
		
		// Draw the cannon and its components.
		// Rotate the cannon barrel to point at the mouse.
		var dx = (GameResources.Mouse.x - cannonXOffset) - this.x;
		var dy = (GameResources.Mouse.y - cannonYOffset) - this.y;
		var angle = Math.atan2(dy,dx);
		
		var angleIsTooLow = angle * (180 / Math.PI) > -5;
		var angleIsTooHigh = angle * (180 / Math.PI) < -90;
		this.rotation = angle;
		
		// Don't allow the cannon to 'over rotate'
		if(angleIsTooLow)
			this.rotation = ANGLE_OFFSET * (Math.PI / 180);
			
		if(angleIsTooHigh)
			this.rotation = (ANGLE_OFFSET - 90) *  (Math.PI / 180);
			
	    GameResources.GameContext.save();
	    GameResources.GameContext.translate(this.x, this.y);
	    GameResources.GameContext.rotate(this.rotation + (ANGLE_OFFSET * Math.PI / 180));
	    GameResources.GameContext.translate(-this.x, -this.y);
		GameResources.GameContext.drawImage(cannonBarrelImg,this.x-cannonXOffset,this.y-cannonYOffset, CANNON_WIDTH,CANNON_HEIGHT);
	    GameResources.GameContext.restore();
	
		// Draw the cannon block.	
		GameResources.GameContext.drawImage(cannonBarrelBlockImg,this.x-cannonBlockXOffset ,this.y-cannonBlockYOffset, CANNON_BLOCK_WIDTH,CANNON_BLOCK_HEIGHT);
	}
	
	// Fire the cannon.
	this.handleClick = function(e){
		
		this.shotsFired++;
		var cannonMouthLocationX = this.x + (Math.cos(this.rotation) * 70);
		var cannonMouthLocationY = this.y + 20 + (Math.sin(this.rotation) * 70);
		
		var cannonBall = new CannonBall(cannonMouthLocationX,cannonMouthLocationY,CANNON_BALL_RADIUS,CANNON_BALL_IMAGE_URL, 'cannonball'+this.shotsFired);
		GameResources.GameLoop.addGameObject(cannonBall);
		cannonBall.applyImpulse((this.rotation * (180 / Math.PI)) + ANGLE_OFFSET,CANNON_BALL_FORCE, new b2Vec2(this.x, this.y));
	}
}