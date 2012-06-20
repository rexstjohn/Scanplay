//
//  SPPhysicsGameLayer.h
//  Flywheels
//
//  Created by Rex St John on 6/19/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "CCLayer.h"
@class SPPhysicsWorld;

@interface SPPhysicsGameLayer : CCLayer 

// Default constructor.
-(id) initWithWorld:(SPPhysicsWorld*)aWorld;

// Wrapped used to access the box2d physics world.
@property(nonatomic,retain) SPPhysicsWorld *world;

@end
