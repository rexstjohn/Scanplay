//
//  UISegmentedControl+Theming.m
//  EatAGram
//
//  Created by Rex St John on 1/22/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "UISegmentedControl+Theming.h"
#import <QuartzCore/QuartzCore.h>

@implementation UISegmentedControl (Theming)

-(void)addBorder:(UIColor*)color withWidth:(NSUInteger)width{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

@end
