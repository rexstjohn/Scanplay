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
#import "PhysicsVars.h"
#import "SPPhysicsContext.h"

@implementation SPPhysicsFactory

@synthesize context = _context;

-(id)initWithPhysicsContext:(SPPhysicsContext*)aContext
{
    _context = aContext;
}

-(SPGear*)createGear:(CGRect)aRect andTeeth:(int)teeth
{
    SPGear *newGear = [[SPGear alloc] initWithRect:aRect];
    return newGear;
}

-(SPPhysicsObject*)createCircleWithRadius:(float32)theRadius withSkin:(NSString*)aSkinURL isDynamic:(BOOL)dynamic
{
    //create the sprite
    //Resources/Icon-72.png
    CCSprite *sprite = [CCSprite spriteWithFile:aSkinURL];
    
    //next, create the physics body
	b2BodyDef bodyDef;
    
    //determine the dynamic nature of the body
    if(dynamic == true) 
        bodyDef.type = b2_dynamicBody;
    else
        bodyDef.type = b2_staticBody;
    
	bodyDef.position.Set(p.x/PhysicsVars.PTM_RATIO, p.y/PhysicsVars.PTM_RATIO);
	bodyDef.userData = sprite; 
	b2Body *body = world->CreateBody(&bodyDef);
	
	// Define another circle shape for our  body.
	b2CircleShape circleShape;
	circleShape.m_radius = theRadius;
	
	// Define the dynamic body fixture.
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &circleShape;	
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 0.3f;
	body->CreateFixture(&fixtureDef);
    
    //return the result
    return [[SPPhysicsObject alloc] initWithBody:body andSprite:sprite];
}

@end
