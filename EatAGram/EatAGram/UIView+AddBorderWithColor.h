//
// Created by jasoncross on 2/26/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "USPMainCustomSubView.h"

@interface UIView (AddBorderWithColor)

- (void)addBorderToRect:(CGRect)rect
         currentContext:(CGContextRef)currentContext
            borderColor:(UIColor *)borderColor
            borderWidth:(CGFloat)borderWidth;

- (void)addBottomBorderToRect:(CGRect)rect
               currentContext:(CGContextRef)currentContext
                  borderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)borderWidth;

- (void)addTopBorderToRect:(CGRect)rect
            currentContext:(CGContextRef)currentContext
               borderColor:(UIColor *)borderColor
               borderWidth:(CGFloat)borderWidth;
@end