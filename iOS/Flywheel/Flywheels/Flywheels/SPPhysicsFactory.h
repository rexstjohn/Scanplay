//
//  SPPhysicsFactory.h
//  Flywheels
//
//  Created by Rex St John on 6/18/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SPPhysicsWorld;
@class SPPhysicsFactory;
@class SPGear;
@class SPPhysicsObject;
@class SPPhysicsContext;

@interface SPPhysicsFactory : NSObject

//init with a physics context
-(id)initWithPhysicsContext:(SPPhysicsContext*)aContext;

//create a basic gear
-(SPGear*)createGear:(CGRect)aRect andTeeth:(int)teeth;

//create a circle
-(SPPhysicsObject*)createCircleWithRadius:(float32)theRadius atPosition:(CGPoint)point withSkin:(NSString*)aSkinURL isDynamic:(BOOL)dynamic;

//create a box
-(SPPhysicsObject*)createBoxWithRect:(CGRect)aRect withSkin:(NSString*)aSkinURL isDynamic:(BOOL)dynamic;


@property(nonatomic,retain) SPPhysicsContext *context;
@property(nonatomic,retain) SPPhysicsWorld *world;

@end
