//
//  UIView+Sliding.m
//  EatAGram
//
//  Created by Rex St John on 2/15/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "UIView+Sliding.h"
#import "UIView+SimpleSizing.h"

@implementation UIView (Sliding)

-(void)revealWithIncrement:(CGFloat)increment
                 andHeader:(UIView*)headerView
                 andFooter:(UIView*)footerView{
    
    CGFloat percentHeightDiff = [headerView sizeHeight] / [footerView sizeHeight];
    CGFloat hidingIncrement = increment; // How much to hide each scroll amount.
    CGFloat heightAdjustedIncrement = (1 - percentHeightDiff) + hidingIncrement;
    
    // Footer.
    CGFloat defaultFooterFloor = [self sizeHeight] + [self frameY];
    CGFloat defaultFooterCeiling = [self sizeHeight] + [self frameY] - [footerView sizeHeight];
    CGFloat footerYAfterScroll = [footerView frameY] + heightAdjustedIncrement;
    CGFloat clampedFooterY = (footerYAfterScroll <= defaultFooterCeiling)?defaultFooterCeiling:footerYAfterScroll;
    clampedFooterY = (clampedFooterY >= defaultFooterFloor)?defaultFooterFloor:clampedFooterY;
    
    // Header.
    CGFloat defaultHeaderCeiling = 0;
    CGFloat defaultHeaderFloor = 0 - [headerView sizeHeight];
    CGFloat headerYAfterScroll = [headerView frameY] - heightAdjustedIncrement;
    CGFloat clampedHeaderY = (headerYAfterScroll >= defaultHeaderCeiling)?defaultHeaderCeiling:headerYAfterScroll;
    clampedHeaderY = (headerYAfterScroll <= defaultHeaderFloor)?defaultHeaderFloor:clampedHeaderY;

    // 
    [footerView setFrameY:clampedFooterY];
    [headerView setFrameY:clampedHeaderY];
}

-(void) revealWithIncrement:(CGFloat)increment andHeader:(UIView *)headerView {
    
    CGFloat hidingIncrement = increment; // How much to hide each scroll amount.
    CGFloat heightAdjustedIncrement = hidingIncrement;
    
    // Header.
    CGFloat defaultHeaderCeiling = 0;
    CGFloat defaultHeaderFloor = 0 - [headerView sizeHeight];
    CGFloat headerYAfterScroll = [headerView frameY] - heightAdjustedIncrement;
    CGFloat clampedHeaderY = (headerYAfterScroll >= defaultHeaderCeiling)?defaultHeaderCeiling:headerYAfterScroll;
    clampedHeaderY = (headerYAfterScroll <= defaultHeaderFloor)?defaultHeaderFloor:clampedHeaderY;
    
    [headerView setFrameY:clampedHeaderY];
}

-(void) revealWithIncrement:(CGFloat)increment andFooter:(UIView *)footerView{
    
    CGFloat hidingIncrement = increment; // How much to hide each scroll amount.
    CGFloat heightAdjustedIncrement = hidingIncrement;
    
    // Footer.
    CGFloat defaultFooterFloor = [self sizeHeight] + [self frameY];
    CGFloat defaultFooterCeiling = [self sizeHeight] + [self frameY] - [footerView sizeHeight];
    CGFloat footerYAfterScroll = [footerView frameY] + heightAdjustedIncrement;
    CGFloat clampedFooterY = (footerYAfterScroll <= defaultFooterCeiling)?defaultFooterCeiling:footerYAfterScroll;
    clampedFooterY = (clampedFooterY >= defaultFooterFloor)?defaultFooterFloor:clampedFooterY;
    
    [footerView setFrameY:clampedFooterY];
}
@end
