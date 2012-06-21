//
//  SPPhysicsGameLayer.m
//  Flywheels
//
//  Created by Rex St John on 6/19/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "SPPhysicsGameLayer.h"
#import "SPPhysicsWorld.h"

@interface SPPhysicsGameLayer()

-(void) tick: (ccTime) dt;

@end

@implementation SPPhysicsGameLayer

@synthesize world = _world;

//TODO: make this not gay.
enum {
	kTagTileMap = 1,
	kTagBatchNode = 1,
	kTagAnimation1 = 1,
};

-(id) initWithWorld:(SPPhysicsWorld*)aWorld {
    
	if( (self=[super init])) {
        
        _world = aWorld;
		
		// enable touches
		self.isTouchEnabled = YES;
		
		// enable accelerometer
		self.isAccelerometerEnabled = YES;
        
		//Set up sprite
		CCSpriteBatchNode *batch = [CCSpriteBatchNode batchNodeWithFile:@"blocks.png" capacity:150];
		[self addChild:batch z:0 tag:kTagBatchNode];
		
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Tap screen" fontName:@"Marker Felt" fontSize:32];
		[self addChild:label z:0];
		[label setColor:ccc3(0,0,255)];
		label.position = ccp( _world.screensize.width/2, _world.screensize.height-50);
		
        // Start the physics updates.
		[self schedule: @selector(tick:)];
    }
    
    return self;
}

-(void) draw{
	// Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	// Needed states:  GL_VERTEX_ARRAY, 
	// Unneeded states: GL_TEXTURE_2D, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	
	[_world drawDebugData]; // Draw the debug graphics.
	
	// restore default GL states
	glEnable(GL_TEXTURE_2D);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
}

// Update the physics world.
-(void) tick: (ccTime) dt {
    [_world step:dt];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	//Add a new body/atlas sprite at the touched location
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
		//[self addNewSpriteWithCoords: location];
	}
}

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration{	
	static float prevX=0, prevY=0;
	
	//#define kFilterFactor 0.05f
    #define kFilterFactor 1.0f	// don't use filter. the code is here just as an example
	
	float accelX = (float) acceleration.x * kFilterFactor + (1- kFilterFactor)*prevX;
	float accelY = (float) acceleration.y * kFilterFactor + (1- kFilterFactor)*prevY;
	
	prevX = accelX;
	prevY = accelY;
	
	// accelerometer values are in "Portrait" mode. Change them to Landscape left
	// multiply the gravity by 10
	b2Vec2 gravity( -accelY * 10, accelX * 10);
	
    // Uncomment to engage gravity changes on rotating the screen.
	//world->SetGravity( gravity );
}

- (void) dealloc{
	[_world release];
    _world = nil;
	[super dealloc];
}
    
@end
