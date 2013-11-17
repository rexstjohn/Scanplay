//
//  UIView+LayoutHelpers.m
//  EatAGram
//
//  Created by Rex St John on 2/6/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "UIView+LayoutHelpers.h"
#import <QuartzCore/QuartzCore.h>
#include <stdlib.h>
#import "UIColor+SimpleColoring.h"

@implementation UIView (LayoutHelpers)

static CGFloat sDefaultBorderWidth = 2.0;

-(void) showMeasurements{
    
    //Add measuremeants
    UILabel *rectLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 12)];
    [rectLabel setNumberOfLines:2];
    [rectLabel setFont:[UIFont systemFontOfSize:11.0]];
    [rectLabel setTextColor:[UIColor whiteColor]];
    [rectLabel setShadowColor:[UIColor blackColor]];
    [rectLabel setShadowOffset:CGSizeMake(1,1)];
    [rectLabel setBackgroundColor:[UIColor clearColor]];
    rectLabel.text = [NSString stringWithFormat:@"Frame: %@ Bounds: %@",NSStringFromCGRect(self.frame),NSStringFromCGRect(self.bounds)];
    [self addSubview:rectLabel];
    
    // Draw borders.
    [self.layer setBorderWidth:sDefaultBorderWidth];
    [self.layer setBorderColor:[self randomColor]];
    
    // Recurse through all subviews, drawing their information.
    NSArray *subViews = [self subviews];
    
    for(UIView *subView in subViews){
        
        BOOL isLabel = [subView isMemberOfClass:[UILabel class]];
        BOOL isButton = [subView isMemberOfClass:[UIButton class]];
        BOOL isNavigationBar= [subView isMemberOfClass:[UINavigationBar class]];
        BOOL isTabBar= [subView isMemberOfClass:[UITabBar class]];
        BOOL isToolBar= [subView isMemberOfClass:[UIToolbar class]];
        BOOL isSegmentedControl= [subView isMemberOfClass:[UISegmentedControl class]];
        BOOL isBarButtonItem = [subView isMemberOfClass:[UIBarButtonItem class]];
        BOOL isImageView = [subView isMemberOfClass:[UIImageView class]];
        
        if(isLabel || isButton || isNavigationBar || isTabBar || isToolBar || isSegmentedControl || isBarButtonItem || isImageView){
            continue;
        }
        
        [subView showMeasurements];
    }
}

-(CGColorRef)randomColor{
    CGFloat r = (CGFloat)(arc4random() % 256);
    CGFloat g = (CGFloat)(arc4random() % 256);
    CGFloat b = (CGFloat)(arc4random() % 256);
    UIColor *randomUIColor = [UIColor simpleColorWithRed:r green:g blue:b alpha:1.0];
    return  [randomUIColor CGColor];
}

-(void)logAttributes{
    NSLog(@"frame: %@ bounds: %@ size: %@ center: %@" , NSStringFromCGRect(self.frame),NSStringFromCGRect(self.bounds),NSStringFromCGSize(self.frame.size),NSStringFromCGPoint(self.center));
}

@end
