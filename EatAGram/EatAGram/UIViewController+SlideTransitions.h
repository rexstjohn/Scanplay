//
//  UIViewController+SlideTransitions.h
//  EatAGram
//
//  Created by Rex St John on 1/23/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SlideTransitions) 

+(void)stopScrollingInViewController:(UIViewController*)viewController;

// It is suggested that this method to be used to swap views of child view controllers inside a container instead of the above method.
- (void) transitionFromView:(UIView*)fromView toView:(UIView*)toView usingContainerView:(UIView*)container andTransition:(NSString*)transitionType;
@end
