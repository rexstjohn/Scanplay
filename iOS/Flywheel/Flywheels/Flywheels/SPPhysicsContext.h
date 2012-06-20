//
//  PhysicsContext.h
//  Flywheels
//
//  Created by Rexford St. John on 6/19/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class SPPhysicsWorld;
@class SPPhysicsFactory;
@class SPPhysicsViewController;

@interface SPPhysicsContext : NSObject

//methods
-(id) initWithWindow:(UIWindow*)aWindow;

//CC scene manager methods.
-(void) pause;
-(void) resume;
-(void) purgeCachedData;
-(void) stopAnimation;
-(void) startAnimation;
-(void) setNextDeltaTimeZero;

// Window in which the game occurs.
@property (nonatomic, retain) UIWindow *window;

// Controller used as the root physics viewcontroller.
@property (nonatomic, retain) SPPhysicsViewController *viewController;

// Physics world wrapper that wraps a box2d world.
@property (nonatomic, retain) SPPhysicsWorld *world;

// Factory used for producing common objects.
@property (nonatomic, retain) SPPhysicsFactory *factory;

// Cocos layer where the game occurs.
@property (nonatomic, retain) CCLayer *layer;

@end
