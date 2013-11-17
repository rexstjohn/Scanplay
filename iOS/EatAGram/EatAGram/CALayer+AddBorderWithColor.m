//
//  CALayer+AddBorderWithColor.m
//  EatAGram
//
//  Created by Rex St John on 3/11/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "CALayer+AddBorderWithColor.h"

@implementation CALayer (AddBorderWithColor)

- (void)addBorderToRect:(CGRect)rect
         currentContext:(CGContextRef)currentContext
            borderColor:(UIColor *)borderColor
            borderWidth:(CGFloat) borderWidth {
    
    CGContextSaveGState(currentContext);
    CGFloat halfBorderWidth = borderWidth / 2.0f;
    CGRect borderedRect = CGRectMake(rect.origin.x + halfBorderWidth,
                                     rect.origin.y + halfBorderWidth,
                                     rect.size.width - borderWidth,
                                     rect.size.height - borderWidth);
    
    // the line is aliased by default, making it appear blurry and 2pixels wide instead of 1px
    CGContextSetShouldAntialias(currentContext, NO);
    
    CGContextSetStrokeColorWithColor(currentContext, [borderColor CGColor]);
    CGContextStrokeRectWithWidth(currentContext, borderedRect, borderWidth);
    CGContextRestoreGState(currentContext);
}

- (void)addBottomBorderToRect:(CGRect)rect
               currentContext:(CGContextRef)context
                  borderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)borderWidth; {
    
    // make a copy of the graphics context state so we can restore it later
    CGContextSaveGState(context);
    
    CGFloat halfBorderWidth = borderWidth / 2.0f;
    CGContextSetLineWidth(context, borderWidth);
    
    // start at this point
    CGPoint startPoint = CGPointMake(rect.origin.x, rect.size.height - halfBorderWidth);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    
    // finish line at this point
    CGPoint finishPoint = CGPointMake(rect.size.width, rect.size.height - halfBorderWidth);
    CGContextAddLineToPoint(context, finishPoint.x, finishPoint.y);
    
    // set color before drawing line
    //[borderColor setStroke];
    CGContextSetStrokeColorWithColor(context, [borderColor CGColor]);
    
    // the line is aliased by default, making it appear blurry and 2pixels wide instead of 1px
    CGContextSetShouldAntialias(context, NO);
    
    // use the context's current color to draw the line
    CGContextStrokePath(context);
    
    // restore the graphics context to its previous state
    CGContextRestoreGState(context);
    
}
@end
