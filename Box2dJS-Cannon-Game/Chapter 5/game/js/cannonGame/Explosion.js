function Explosion(_x,_y,_explosionImageURL,_particleCount){
	
	var PARTICLE_RADIUS  = 10;
	
	var particles = new Array();
	
	// Generate a list of particles.
	for(var i = 0 ; i < _particleCount; i++){
		
		var newParticle = new GameCircle(_x,_y,PARTICLE_RADIUS,_explosionImageURL, "particle"+i);
		particles.push(newParticle);
		GameResources.GameLoop.addGameObject(newParticle);
		ApplyImpulse(newParticle,PhysicsUtils.RandomNumberInRange(1,360),PhysicsUtils.RandomNumberInRange(50000,90000),newParticle.body.GetCenterPosition());
	}
	
	this.update = function(){
		
		for(var i = 0 ; i < particles.length; i++){

			particles[i].update();
		}
	}
	
	// Put some force on the particle.
	function ApplyImpulse(_particle,_angle,_force, _startingPosition){
		
		// Apply a random force to the particles.
		_particle.body.ApplyImpulse(new b2Vec2(Math.cos(_angle * (Math.PI / 180)) * _force,
		                                 Math.sin(_angle * (Math.PI / 180)) * _force),
		                                 _startingPosition);
	}
	
}