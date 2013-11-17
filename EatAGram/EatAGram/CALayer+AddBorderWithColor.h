//
//  CALayer+AddBorderWithColor.h
//  EatAGram
//
//  Created by Rex St John on 3/11/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (AddBorderWithColor)

- (void)addBorderToRect:(CGRect)rect
         currentContext:(CGContextRef)currentContext
            borderColor:(UIColor *)borderColor
            borderWidth:(CGFloat)borderWidth;

- (void)addBottomBorderToRect:(CGRect)rect
               currentContext:(CGContextRef)currentContext
                  borderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)borderWidth;
@end
