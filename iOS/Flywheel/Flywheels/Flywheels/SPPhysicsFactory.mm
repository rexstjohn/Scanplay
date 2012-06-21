//
//  SPPhysicsFactory.m
//  Flywheels
//
//  Created by Rex St John on 6/18/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "SPPhysicsFactory.h"
#import "SPPhysicsWorld.h"
#import "SPPhysicsContext.h"
#import "GameConfig.h"
#import "SMXMLDocument.h"
#import "SPPhysicsObject.h"
#import "SPPhysicsPrefab.h"

@implementation SPPhysicsFactory

//TODO: make this less gay
enum {
	kTagTileMap = 1,
	kTagBatchNode = 1,
	kTagAnimation1 = 1,
};

@synthesize context = _context, world = _world;

-(id)initWithPhysicsContext:(SPPhysicsContext*)aContext{
    
    if(self = [super init]){
        
        _context = aContext;
        _world = aContext.world;
    }
    
    return self;
}

//
-(void)createObjectFromPrefab:(SPPhysicsPrefab*)aPrefab andRect:(CGRect)aRect{
    
   // id object = [[NSClassFromString(aPrefab.className) alloc] init];

}

-(SPPhysicsObject*)createCircleWithRadius:(float)theRadius 
                               atPosition:(CGPoint)point 
                                 withSkin:(NSString*)aSkinURL 
                                isDynamic:(BOOL)dynamic{
    
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
	bodyDef.position.Set(point.x/PTM_RATIO, point.y/PTM_RATIO);
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
    
    // Create the sprite
    CCSprite *sprite = [CCSprite spriteWithFile:aSkinURL];
    
    // Create the body.
	b2BodyDef bodyDef;
    
    // Determine the dynamic nature of the body.
    if(dynamic == true) 
        bodyDef.type = b2_dynamicBody;
    else
        bodyDef.type = b2_staticBody;
    
    //
	bodyDef.position.Set(aRect.origin.x/PTM_RATIO, aRect.origin.y/PTM_RATIO);
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

-(SPPhysicsObject*)createPolygonWithPoints:(NSArray*)somePoints withSkin:(NSString*)aSkinURL isDynamic:(BOOL)dynamic atPoint:(CGPoint)aPoint{
    
    // Create the sprite
    CCSprite *sprite = [CCSprite spriteWithFile:aSkinURL];
    
    // Create the body.
	b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(aPoint.x/PTM_RATIO, aPoint.y/PTM_RATIO);
    bodyDef.userData = sprite;
    
    // Determine the dynamic nature of the body.
    if(dynamic == true) 
        bodyDef.type = b2_dynamicBody;
    else
        bodyDef.type = b2_staticBody;
    
    // Define the polygon shape
//    int num = 5;
//    
//    b2Vec2 verts[] = {
//        b2Vec2(0.0f*sprite.scale / PTM_RATIO, 40.8f*sprite.scale / PTM_RATIO),
//        b2Vec2(-32.2f*sprite.scale / PTM_RATIO, 35.0f*sprite.scale / PTM_RATIO),
//        b2Vec2(-20.0f*sprite.scale / PTM_RATIO, -40.0f*sprite.scale / PTM_RATIO),
//        b2Vec2(20.0f*sprite.scale / PTM_RATIO, -40.0f*sprite.scale / PTM_RATIO),
//        b2Vec2(32.2f*sprite.scale / PTM_RATIO, 35.0f*sprite.scale / PTM_RATIO)
//    };
    int num = [somePoints count];
    b2Vec2 verts[] = {};
    
    for (int i =0; i < [somePoints count]; i++) {
        CGPoint point = [[somePoints objectAtIndex:i] CGPointValue];
        verts[i] =  b2Vec2(point.x*sprite.scale / PTM_RATIO,point.y*sprite.scale / PTM_RATIO);
    }
    
    b2PolygonShape shape;
    shape.Set(verts, num);
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &shape;
    fixtureDef.density = 0.1 ;
    fixtureDef.friction = 0.5 ;
    fixtureDef.restitution = 0.4 ;
    
    // Create the body
    b2Body *body = [_world createBody:&bodyDef];
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
