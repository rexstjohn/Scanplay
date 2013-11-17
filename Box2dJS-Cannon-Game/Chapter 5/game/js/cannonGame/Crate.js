// A crate.
function Crate(_x,_y,_id){
	
	var NORMAL_SKIN = 'assets/art/wooden_block.png';
	var DAMAGED_SKIN = 'assets/art/wooden_block_damaged.png';
	var PARTICLE_SKIN = 'assets/art/wooden_block_damaged.png';
	
	// Define the body of our box.
	this.height = 35;
	this.width  = 35;
	this.body = PhysicsUtils.CreateDynamicBox(GameResources.GameWorld.world,_x,_y,this.width,this.height);
	this.id = this.body.userData = _id;
	this.type = 'crate';
	this.isDestroyed = false;
	this.health = 2200;
	
	// Load the skin image.
    var skin = new Image();
    skin.src = NORMAL_SKIN;
	
	this.update = function(){
		
		PhysicsUtils.BindGraphicToBox2DBody(this.body,skin, this.width,this.height);
	}
	
	// How much damage do we take from the cannon ball?
	this.handleCollission = function(_entity){
		
		// Did we collide with a cannon ball?
		if(_entity.hasOwnProperty('type') && _entity.type == 'cannon_ball')
		{
			// How much damage did the impact do?
			if(this.health <= 0){
			
				// Shatter up if we are out of health.
				var x = _entity.body.GetCenterPosition().x;
				var y = _entity.body.GetCenterPosition().y;
				var explosion = new Explosion(x,y, PARTICLE_SKIN,5)
				GameResources.GameLoop.addGameObject(explosion);
				this.destroy();
				
			}else{
				
				// This is a simple way to do damage to the crate.
				// Change the skin to a damaged skin.
				this.health -= _entity.body.GetLinearVelocity().x;
				skin.src = DAMAGED_SKIN;
			}
		}
	}
	
	// Destroy the crate and remove it from the game.
	this.destroy = function(){
		
		// Destroy the body of the object and remove it from the update loop
		this.isDestroyed=true;
		GameResources.GameWorld.world.DestroyBody(this.body);
		GameResources.GameLoop.removeGameObject(this);
	}
}