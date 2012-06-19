//
//  PhysicsContext.m
//  Flywheels
//
//  Created by Rexford St. John on 6/19/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "SPPhysicsContext.h"
#import "SPPhysicsWorld.h"
#import "SPPhysicsFactory.h"

@implementation SPPhysicsContext

@synthesize world = _world, factory = _factory;

-(id)init
{
    if(self = [super init])
    {
        //create our physics world
        _world = [[SPPhysicsWorld alloc] init];
        
        //create our factory
        _factory = [[SPPhysicsFactory alloc] initWithPhysicsContext:self];
    }
}

@end
