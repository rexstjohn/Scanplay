//
//  AppDelegate.h
//  Flywheels
//
//  Created by Rex St John on 6/18/12.
//  Copyright Scanplay Games 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPPhysicsContext;


@interface AppDelegate : NSObject <UIApplicationDelegate> 

// Window in which the game occurs.
@property (nonatomic, retain) UIWindow *window;

// Physics context contains everything needed to run the game.
@property (nonatomic, retain) SPPhysicsContext *context;

@end
