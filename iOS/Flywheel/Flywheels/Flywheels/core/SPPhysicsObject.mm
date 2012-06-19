//
//  SPPhysicsObject.m
//  Flywheels
//
//  Created by Rex St John on 6/18/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "SPPhysicsObject.h"

@implementation SPPhysicsObject

// create ivars & syntesize
@synthesize sprite = _sprite;

-(id)initWithBody:(b2Body*) body andSprite:(CCSprite*) sprite
{
    if(self = [super init])
    {
        _body = body;
        _sprite = sprite;
    }
    
    return self;
}

- (void) dealloc 
{
    //dealloc
    [_sprite dealloc];
    
    //nil
     _body = NULL; //the world handles the destruction of these bodies.
    _sprite= nil;
    [super dealloc];
}

@end
