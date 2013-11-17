//
//  UIView+Sliding.h
//  EatAGram
//
//  Created by Rex St John on 2/15/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Sliding)

-(void)revealWithIncrement:(CGFloat)increment
                 andHeader:(UIView*)headerView
                 andFooter:(UIView*)footerView;

-(void) revealWithIncrement:(CGFloat)increment
                  andHeader:(UIView *)headerView;

-(void) revealWithIncrement:(CGFloat)increment
                  andFooter:(UIView *)footerView;
@end
