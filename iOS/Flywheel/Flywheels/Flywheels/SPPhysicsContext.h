//
//  PhysicsContext.h
//  Flywheels
//
//  Created by Rexford St. John on 6/19/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPPhysicsWorld.h"
#import "SPPhysicsFactory.h"

@interface SPPhysicsContext : NSObject

-(id)init;

@property (nonatomic, retain) SPPhysicsWorld *world;
@property (nonatomic, retain) SPPhysicsFactory *factory;


@end
