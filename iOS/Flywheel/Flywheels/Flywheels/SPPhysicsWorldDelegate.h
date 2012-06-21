//
//  SPPhysicsWorldDelegate.h
//  Flywheels
//
//  Created by Rexford St. John on 6/21/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "b2World.h"
#import "GLES-Render.h"

// Applied to the wrapper around the b2World class.
@protocol SPPhysicsWorldDelegate <NSObject>

@required
-(b2Body*)createBody:(b2BodyDef*)aBodyDef;
-(b2Joint*)createJoint:(b2JointDef*)aJointDef;

@end
