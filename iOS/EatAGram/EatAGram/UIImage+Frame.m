//
//  UIImage+Frame.m
//  EatAGram
//
//  Created by Rex St John on 3/26/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "UIImage+Frame.h"

@implementation UIImage (Frame)

-(UIImage*)imageWithFrameColor:(UIColor*)color andWidth:(CGFloat)frameWidth{
     
    UIGraphicsBeginImageContext(self.size); 
    [self drawAtPoint:CGPointZero];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect imageRect = CGRectMake(-frameWidth, -frameWidth, self.size.width+(frameWidth*2), self.size.height+(frameWidth*2));
    CGRect innerRect = CGRectInset(imageRect, frameWidth, frameWidth);
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    CGContextSetLineWidth(context, frameWidth);
    
    // Draw the outer square.
    CGContextMoveToPoint(context, CGRectGetMinX(innerRect), CGRectGetMinY(innerRect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(innerRect), CGRectGetMinY(innerRect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(innerRect), CGRectGetMaxY(innerRect));
    CGContextAddLineToPoint(context, CGRectGetMinX(innerRect), CGRectGetMaxY(innerRect));
    
    // Finish the square
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    // Render down into another image.
    UIImage *framedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return framedImage;
}

@end
