//
//  SPPhysicsViewController.m
//  Flywheels
//
//  Created by Rex St John on 6/19/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "SPPhysicsViewController.h"
#import "GameConfig.h"

@implementation SPPhysicsViewController

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    // EAGLView will be rotated by cocos2d
	if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
		[[CCDirector sharedDirector] setDeviceOrientation: kCCDeviceOrientationLandscapeRight];
	else if(interfaceOrientation == UIInterfaceOrientationLandscapeRight)
		[[CCDirector sharedDirector] setDeviceOrientation: kCCDeviceOrientationLandscapeLeft];
	
	// Since this method should return YES in at least 1 orientation, 
	// we return YES only in the Portrait orientation
	return ( interfaceOrientation == UIInterfaceOrientationPortrait );
}

@end
