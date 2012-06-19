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
@synthesize body = _body, sprite = _sprite;

-(id)initWithBody:(b2Body*) body andSprite:(CCSprite*) sprite
{
    _body = body;
    _sprite = sprite;
}

@end
