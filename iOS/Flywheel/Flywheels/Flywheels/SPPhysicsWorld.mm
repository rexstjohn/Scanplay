//
//  SPPhysicsWorld.m
//  Flywheels
//
//  Created by Rexford St. John on 6/19/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "SPPhysicsWorld.h"
#import "b2World.h"
#import "b2Body.h"
#import "GLES-Render.h"
#import "b2PolygonShape.h"
#import "GameConfig.h"

@interface  SPPhysicsWorld ()

// Generate a debug draw.
-(void) createDebugDraw;

// Create a ground body to contain the world.
- (void) createGroundBodyInRect:(CGRect)aRect;

@end

@implementation SPPhysicsWorld

@synthesize screensize = _screensize;

-(id)initWithSize:(CGSize)aSize{  
    
    if(self = [super init]){
        
        _screensize = aSize;
        
        // Define the gravity vector.
        b2Vec2 gravity;
        gravity.Set(0.0f, kGRAVITY);
        
        // Do we want to let bodies sleep?
        // This will speed up the physics simulation
        bool doSleep = kDO_SLEEP;
        
        // Construct a world object, which will hold and simulate the rigid bodies.
        _world = new b2World(gravity, doSleep);        
        _world->SetContinuousPhysics(true);
        		
        //create the debug draw
        [self createDebugDraw];
        
        //create the ground body
        CGRect groundRect = CGRectMake(0, 0, _screensize.width/kPTM_RATIO, _screensize.height/kPTM_RATIO);
        [self createGroundBodyInRect:groundRect];
        
    }
    
    return self;
}

// Wrapper methods.
-(b2Body*)createBody:(b2BodyDef*)aBodyDed{
    return _world->CreateBody(aBodyDed);
}

-(b2Joint*)createJoint:(b2JointDef*)aJointDef{
    return _world->CreateJoint(aJointDef);
}

-(void)drawDebugData{
    _world->DrawDebugData();
}

// Private methods.

-(void) createDebugDraw {
    
    // Debug Draw functions
    _debugDraw = new GLESDebugDraw(kPTM_RATIO);
    _world->SetDebugDraw(_debugDraw);
    
    uint32 flags = 0;
    flags += b2DebugDraw::e_shapeBit;
    //		flags += b2DebugDraw::e_jointBit;
    //		flags += b2DebugDraw::e_aabbBit;
    //		flags += b2DebugDraw::e_pairBit;
    //		flags += b2DebugDraw::e_centerOfMassBit;
    _debugDraw->SetFlags(flags);
}

-(void)createGroundBodyInRect:(CGRect)aRect {
    
    // Define the ground body.
    b2BodyDef groundBodyDef;
    groundBodyDef.position.Set(aRect.origin.x, aRect.origin.y); // bottom-left corner
    
    // Call the body factory which allocates memory for the ground body
    // from a pool and creates the ground box shape (also from a pool).
    // The body is also added to the world.
    b2Body* groundBody = _world->CreateBody(&groundBodyDef);
    
    // Define the ground box shape.
    b2PolygonShape groundBox;		
    
    // bottom
    groundBox.SetAsEdge(b2Vec2(0,0), b2Vec2(aRect.size.width,0));
    groundBody->CreateFixture(&groundBox,0);
    
    // top
    groundBox.SetAsEdge(b2Vec2(0,aRect.size.height), b2Vec2(aRect.size.width,aRect.size.height));
    groundBody->CreateFixture(&groundBox,0);
    
    // left
    groundBox.SetAsEdge(b2Vec2(0,aRect.size.height), b2Vec2(0,0));
    groundBody->CreateFixture(&groundBox,0);
    
    // right
    groundBox.SetAsEdge(b2Vec2(aRect.size.width,aRect.size.height), b2Vec2(aRect.size.width,0));
    groundBody->CreateFixture(&groundBox,0);
}

// Update the physics world.
-(void)step:(ccTime) dt{
    
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	_world->Step(dt, velocityIterations, positionIterations);
	
	//Iterate over the bodies in the physics world
	for (b2Body* b = _world->GetBodyList(); b; b = b->GetNext()) {
        
		if (b->GetUserData() != NULL) {
            
			//Synchronize the AtlasSprites position and rotation with the corresponding body
			CCSprite *myActor = (CCSprite*)b->GetUserData();
			myActor.position = CGPointMake( b->GetPosition().x * kPTM_RATIO, b->GetPosition().y * kPTM_RATIO);
			myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
		}	
	}
}


- (void) dealloc {
    
    //delete
    delete _world;
	delete _debugDraw;
    
    //null
    _debugDraw = NULL;
    _world     = NULL;
    
    [super dealloc];
}

@end
