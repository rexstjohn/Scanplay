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


@interface SPPhysicsWorld : NSObject {
    
    //these items are C++ class objects so they must be handled differently memory-wise.
    b2World *_world;
    GLESDebugDraw *_debugDraw;
}

-(id)initWithSize:(CGSize)aSize;

//
@property(nonatomic, assign) CGSize screensize;

//wrapper functions
-(b2Body*)createBody:(b2BodyDef*)aBodyDef;
-(b2Joint*)createJoint:(b2JointDef*)aJointDef;
-(void)drawDebugData;
-(void)step:(ccTime) dt;

@end
