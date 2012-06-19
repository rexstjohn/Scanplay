//
//  SPPhysicsWorld.h
//  Flywheels
//
//  Created by Rexford St. John on 6/19/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "b2World.h"

#define PTM_RATIO = 32

@interface SPPhysicsWorld : NSObject

-(id)init;

@property(nonatomic,retain) b2World *world;
@end
