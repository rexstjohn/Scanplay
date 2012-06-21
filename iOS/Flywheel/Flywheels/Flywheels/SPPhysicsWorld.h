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
#import "SPPhysicsWorldDelegate.h"

@interface SPPhysicsWorld : NSObject <SPPhysicsWorldDelegate> {
    
    //these items are C++ class objects so they must be handled differently memory-wise.
    b2World *_world;
    GLESDebugDraw *_debugDraw;
}

-(id)initWithSize:(CGSize)aSize;

//
@property(nonatomic, assign) CGSize screensize;

// Wrapper constructor delegate functions for b2World.
-(b2Body*)createBody:(b2BodyDef*)aBodyDef;
-(b2Joint*)createJoint:(b2JointDef*)aJointDef;

// Draw debug data for the world.
-(void)drawDebugData;

// Step the world physics.
-(void)step:(ccTime) dt;

@end
