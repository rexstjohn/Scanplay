//
//  SPPhysicsWorld.h
//  Flywheels
//
//  Created by Rexford St. John on 6/19/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "b2World.h"
#import "GLES-Render.h"

#define GRAVITY    -10f
#define DO_SLEEP  true
#define PTM_RATIO  32

@interface SPPhysicsWorld : NSObject

-(id)initWithSize:(CGSize)aSize;

//wrapper functions
-(b2Body*)createBody:(b2BodyDef*)aBodyDef;
-(b2Joint*)createJoint:(b2JointDef*)aJointDef;

@property(nonatomic) b2World *world;
@property (nonatomic) GLESDebugDraw *debugDraw;

@end
