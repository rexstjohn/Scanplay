//
//  UIView+Borders.m
//  EatAGram
//
//  Created by Rex St John on 2/26/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "UIView+Borders.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation UIView (Borders)

-(void)addBorderWithColor:(UIColor*)color width:(CGFloat)width inRect:(CGRect)rect{ 
    CGContextRef currentContext = UIGraphicsGetCurrentContext(); 
    CGFloat halfBorderWidth = width / 2.0f;
    CGRect borderedRect = CGRectMake(rect.origin.x + halfBorderWidth,
                                     rect.origin.y + halfBorderWidth,
                                     rect.size.width - halfBorderWidth,
                                     rect.size.height  - halfBorderWidth);
    
    // the line is aliased by default, making it appear blurry and 2pixels wide instead of 1px
    CGContextSetShouldAntialias(currentContext, NO);
    CGContextSetStrokeColorWithColor(currentContext, [color CGColor]);
    CGContextStrokeRectWithWidth(currentContext, borderedRect, width);
}

@end
