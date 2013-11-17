//
//  UIView+RelativeLayouts.h
//  EatAGram
//
//  Created by Rex St John on 2/26/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RelativeLayouts)

+(void)layoutViews:(NSArray*)views withSpacing:(CGFloat)spacing atPoint:(CGPoint)startingPoint;

-(void)layoutBelowView:(UIView*)topView withSpacing:(CGFloat)spacing;

@end
