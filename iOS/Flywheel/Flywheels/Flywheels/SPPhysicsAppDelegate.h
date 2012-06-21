//
//  SPPhysicsAppDelegate.h
//  Flywheels
//
//  Created by Rexford St. John on 6/21/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import <Foundation/Foundation.h>

// Functions that must be supported by the physics app delegate.
@protocol SPPhysicsAppDelegate <NSObject>

@required
-(void) pause;
-(void) resume;
-(void) purgeCachedData;
-(void) stopAnimation;
-(void) startAnimation;
-(void) setNextDeltaTimeZero;

@end
