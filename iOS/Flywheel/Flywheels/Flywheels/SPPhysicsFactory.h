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
@class SPPhysicsObject;
@class SPPhysicsContext;
@class SPPhysicsPrefab;
@class SMXMLElement;

@interface SPPhysicsFactory : NSObject

//init with a physics context
-(id)initWithPhysicsContext:(SPPhysicsContext*)aContext;

//create an object given a prefab
-(void) createObjectFromPrefab:(SPPhysicsPrefab*)aPrefab andElement:(SMXMLElement*)anElement;

//create a circle
-(SPPhysicsObject*)createCircleWithRadius:(float32)theRadius atPosition:(CGPoint)point withSkin:(NSString*)aSkinURL isDynamic:(BOOL)dynamic;

//create a box
-(SPPhysicsObject*)createBoxWithRect:(CGRect)aRect withSkin:(NSString*)aSkinURL isDynamic:(BOOL)dynamic;

// Create a polygon shape given a list of CCW points.
-(SPPhysicsObject*)createPolygonWithPoints:(NSArray*)somePoints withSkin:(NSString*)aSkinURL isDynamic:(BOOL)dynamic atPoint:(CGPoint)aPoint;


@property(nonatomic,retain) SPPhysicsContext *context;
@property(nonatomic,retain) SPPhysicsWorld *world;

@end
