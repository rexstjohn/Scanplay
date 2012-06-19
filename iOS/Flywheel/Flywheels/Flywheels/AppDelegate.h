//
//  AppDelegate.h
//  Flywheels
//
//  Created by Rex St John on 6/18/12.
//  Copyright Scanplay Games 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
