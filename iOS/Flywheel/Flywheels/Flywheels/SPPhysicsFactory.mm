//
//  SPPhysicsFactory.m
//  Flywheels
//
//  Created by Rex St John on 6/18/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "SPPhysicsFactory.h"
#import "SPGear.h"
#import "SPPhysicsObject.h"
#import "SPPhysicsWorld.h"
#import "SPPhysicsContext.h"
#import "GameConfig.h"

@implementation SPPhysicsFactory

@synthesize context = _context, world = _world;

-(id)initWithPhysicsContext:(SPPhysicsContext*)aContext{
    
    if(self = [super init]){
        
        _context = aContext;
        _world = aContext.world;
    }
    
    return self;
}

-(SPGear*)createGear:(CGRect)aRect andTeeth:(int)teeth{
    
    SPGear *newGear = [[SPGear alloc] initWithRect:aRect];
    return newGear;
}

-(SPPhysicsObject*)createCircleWithRadius:(float32)theRadius atPosition:(CGPoint)point withSkin:(NSString*)aSkinURL isDynamic:(BOOL)dynamic{
    
    //create the sprite
    //Resources/Icon-72.png
    CCSprite *sprite = [CCSprite spriteWithFile:aSkinURL];
    
	b2BodyDef bodyDef;
    
    // Determine the dynamic nature of the body.
    if(dynamic == true) 
        bodyDef.type = b2_dynamicBody;
    else
        bodyDef.type = b2_staticBody;
    
    //
	bodyDef.position.Set(point.x/kPTM_RATIO, point.y/kPTM_RATIO);
	bodyDef.userData = sprite;  // Assign the sprite representation of the body.
	b2Body *body = [_world createBody:&bodyDef];
	
	// Define another circle shape for our  body.
	b2CircleShape circleShape;
	circleShape.m_radius = theRadius;
	
	// Define the dynamic body fixture.
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &circleShape;	
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 0.3f;
	body->CreateFixture(&fixtureDef);
    
    // Return the result.
    return [[SPPhysicsObject alloc] initWithBody:body andSprite:sprite];
}

-(SPPhysicsObject*)createBoxWithRect:(CGRect)aRect withSkin:(NSString*)aSkinURL isDynamic:(BOOL)dynamic{
    
    //create the sprite
    //Resources/Icon-72.png
    CCSprite *sprite = [CCSprite spriteWithFile:aSkinURL];
    
	b2BodyDef bodyDef;
    
    // Determine the dynamic nature of the body.
    if(dynamic == true) 
        bodyDef.type = b2_dynamicBody;
    else
        bodyDef.type = b2_staticBody;
    
    //
	bodyDef.position.Set(aRect.origin.x/kPTM_RATIO, aRect.origin.y/kPTM_RATIO);
	bodyDef.userData = sprite;  // Assign the sprite representation of the body.
    b2Body *body = [_world createBody:&bodyDef];
	
	// Define another circle shape for our  body.
	b2PolygonShape boxShape;
	boxShape.SetAsBox(aRect.size.width, aRect.size.height);//These are mid points for our 1m box
	
	// Define the dynamic body fixture.
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &boxShape;	
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 0.3f;
	body->CreateFixture(&fixtureDef);
    
    // Return the result.
    return [[SPPhysicsObject alloc] initWithBody:body andSprite:sprite];
}

- (void) dealloc {
    
    //release
    [_world release];
    [_context release];
    
    //nil
    _world = nil;
    _context = nil;
    [super dealloc];
}

@end
