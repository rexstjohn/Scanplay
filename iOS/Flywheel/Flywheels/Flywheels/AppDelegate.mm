//
//  AppDelegate.m
//  Flywheels
//
//  Created by Rex St John on 6/18/12.
//  Copyright Scanplay Games 2012. All rights reserved.
//

#import "cocos2d.h"
#import "AppDelegate.h"
#import "SPPhysicsContext.h"

@implementation AppDelegate

@synthesize window=_window, context=_context;

- (void) applicationDidFinishLaunching:(UIApplication*)application{
    
	// Init the window.
	_window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
    // Create the physics context and launch the game environment.
	_context = [[SPPhysicsContext alloc] initWithWindow:_window];
}

// Delegate methods.
- (void)applicationWillResignActive:(UIApplication *)application {
	[_context pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[_context resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[_context purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[_context stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[_context startAnimation];
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[_context setNextDeltaTimeZero];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    //release
	[_context release];
	[_window release];
	[_context release];
    
    //nil
    _context = nil;
    _window = nil;
}

- (void)dealloc {
    
    //release
	[_context release];
	[_context release];
	[_window release];
    
    //nil
    _context = nil;
    _window = nil;
	[super dealloc];
}

@end
