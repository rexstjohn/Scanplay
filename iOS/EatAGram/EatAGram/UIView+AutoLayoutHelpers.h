//
//  UIView+AutoLayoutHelpers.h
//  EatAGram
//
//  Created by Rex St John on 3/13/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AutoLayoutHelpers)

-(void)addEqualityConstraintOn:(NSLayoutAttribute)attribute forSubview:(UIView*)subview;
-(void)centerSubview:(UIView*)subview;
-(void)centerYSubview:(UIView*)subview;
-(void)centerXSubview:(UIView*)subview;
-(void)pinLeadingEdgeWithValue:(CGFloat)value;

-(void)pinTopEdgeWithValue:(CGFloat)value;

-(void)pinTopEdgeWithValue:(CGFloat)value toBottomOfSubview:(UIView*)subview;
-(void)pinBottomEdgeWithValue:(CGFloat)value toSubview:(UIView*)subview;
-(void)pinHeightWithValue:(CGFloat)height;
-(void)pinWidthWithValue:(CGFloat)width;

// Makes two views space either vertically or horizontally from one another.
-(void)addVerticalSpaceBetweenTopView:(UIView *)topView andBottomView:(UIView *)bottomView withDistance:(CGFloat)dist;
-(void)addHorizontalSpaceBetweenLeftView:(UIView *)leftView andRightView:(UIView *)rightView withDistance:(CGFloat)dist;

// Use this to modify a view's height / width constraint, will automatically add a height constraint if none is found.
-(void)updateHeightConstraint:(CGFloat)newHeight;
-(void)updateWidthConstraint:(CGFloat)newWidth;
-(void)removeHeightConstraints;
-(void)removeWidthConstraints;

// Use these to enforce content hugging and compression to prevent squishing of things.
-(void)setCompressable:(BOOL)compressable;
-(void)setHugsContent:(BOOL)hugsContent;
-(void)setHorizontallyCompressable:(BOOL)isCompressable;
-(void)setVerticallyCompressable:(BOOL)isCompressable;
-(void)setHugsContentHorizontally:(BOOL)hugsContent;
-(void)setHugsContentVertically:(BOOL)hugsContent;

@end
