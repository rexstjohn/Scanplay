//
//  SPPhysicsFactory.h
//  Flywheels
//
//  Created by Rex St John on 6/18/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPPhysicsFactory.h"
#import "SPGear.h"
#import "SPPhysicsObject.h"
#import "SPPhysicsContext.h"

@interface SPPhysicsFactory : NSObject

-(id)initWithPhysicsContext:(SPPhysicsContext*)aContext;
-(SPGear*)createGear:(CGRect)aRect andTeeth:(int)teeth;
-(SPPhysicsObject*)createCircleWithRadius:(float32)theRadius withSkin:(NSString*)aSkinURL isDynamic:(BOOL)dynamic;

@property(nonatomic,retain) PhysicsContext *context;

@end
