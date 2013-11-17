//
//  UIView+AutoLayoutHelpers.m
//  EatAGram
//
//  Created by Rex St John on 3/13/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "UIView+AutoLayoutHelpers.h"

@implementation UIView (AutoLayoutHelpers)
- (void)addEqualityConstraintOn:(NSLayoutAttribute)attribute forSubview:(UIView*)subview {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:subview
                                                      attribute:attribute
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self
                                                      attribute:attribute
                                                     multiplier:1.0
                                                       constant:0.0]];
}


-(void)centerSubview:(UIView*)subview {
    
}

-(void)centerYSubview:(UIView*)subview {
    
   [subview.superview addConstraint:[NSLayoutConstraint
                                       constraintWithItem:subview
                                       attribute:NSLayoutAttributeCenterY
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:subview.superview
                                       attribute:NSLayoutAttributeCenterY
                                       multiplier:1.0
                                       constant:0]];
}

-(void)centerXSubview:(UIView*)subview {
    
   // [self.superview clearCenterXConstraintsForSubview:subview];
    
   [subview.superview addConstraint:[NSLayoutConstraint
                              constraintWithItem:subview
                              attribute:NSLayoutAttributeCenterX
                              relatedBy:NSLayoutRelationEqual
                              toItem:subview.superview
                              attribute:NSLayoutAttributeCenterX
                              multiplier:1.0
                              constant:0]];

}

#pragma mark - Pins


-(void)pinLeadingEdgeWithValue:(CGFloat)value{
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    // Clean out any existing leading edge relationship between this subview and it's superview.
    [self clearLeadingEdgeConstraintsForSubview:self];
    
    [self.superview addConstraint:[NSLayoutConstraint
                              constraintWithItem:self
                              attribute:NSLayoutAttributeLeading
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.superview
                              attribute:NSLayoutAttributeLeading
                              multiplier:1.0
                              constant:value]];
    
}

-(void)pinTrailingEdgeForSubview:(UIView*)subview  withValue:(CGFloat)value{
    
    [subview setTranslatesAutoresizingMaskIntoConstraints:NO];
    // Clean out any existing trailing edge relationship between this subview and it's superview.
    [self clearTrailingEdgeConstraintsForSubview:subview];
    
    [self addConstraint:[NSLayoutConstraint
                              constraintWithItem:subview
                              attribute:NSLayoutAttributeTrailing
                              relatedBy:NSLayoutRelationEqual
                              toItem:self
                              attribute:NSLayoutAttributeTrailing
                              multiplier:1.0
                              constant:value]];
}

-(void)pinTopEdgeWithValue:(CGFloat)value{
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.superview addConstraint:[NSLayoutConstraint
                              constraintWithItem:self
                              attribute:NSLayoutAttributeTop
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.superview
                              attribute:NSLayoutAttributeTop
                              multiplier:1.0
                              constant:value]];
}


-(void)pinTopEdgeWithValue:(CGFloat)value toBottomOfSubview:(UIView*)subview{
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.superview addConstraint:[NSLayoutConstraint
                                   constraintWithItem:self
                                   attribute:NSLayoutAttributeTop
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:subview
                                   attribute:NSLayoutAttributeTop
                                   multiplier:1.0
                                   constant:value]];
}

-(void)pinBottomEdgeWithValue:(CGFloat)value toSubview:(UIView*)subview{
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.superview addConstraint:[NSLayoutConstraint
                                   constraintWithItem:self
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:subview
                                   attribute:NSLayoutAttributeBottom
                                   multiplier:1.0
                                   constant:value]];
}

-(void)pinBottomEdge{
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.superview addConstraint:[NSLayoutConstraint
                              constraintWithItem:self
                              attribute:NSLayoutAttributeBottom
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.superview
                              attribute:NSLayoutAttributeBottom
                              multiplier:1.0
                              constant:0]];
}

-(void)pinHeight{
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addConstraint:[NSLayoutConstraint
                              constraintWithItem:self
                              attribute:NSLayoutAttributeHeight
                              relatedBy:NSLayoutRelationEqual
                              toItem:nil
                              attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                              constant:self.frame.size.height]];
}

-(void)pinWidth {
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.superview addConstraint:[NSLayoutConstraint
                              constraintWithItem:self
                              attribute:NSLayoutAttributeWidth
                              relatedBy:NSLayoutRelationEqual
                              toItem:nil
                              attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1.0
                              constant:self.frame.size.width]];
}

-(void)pinHeightWithValue:(CGFloat)height{
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO]; 
    
    [self.superview addConstraint:[NSLayoutConstraint
                         constraintWithItem:self
                         attribute:NSLayoutAttributeHeight
                         relatedBy:NSLayoutRelationEqual
                         toItem:nil
                         attribute:NSLayoutAttributeNotAnAttribute
                         multiplier:1.0
                         constant:height]];
}

-(void)pinWidthWithValue:(CGFloat)width{
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.superview addConstraint:[NSLayoutConstraint
                         constraintWithItem:self
                         attribute:NSLayoutAttributeWidth
                         relatedBy:NSLayoutRelationEqual
                         toItem:nil
                         attribute:NSLayoutAttributeNotAnAttribute
                         multiplier:1.0
                         constant:width]];
}

-(void)addVerticalSpaceBetweenTopView:(UIView *)topView andBottomView:(UIView *)bottomView withDistance:(CGFloat)dist {
    [self addConstraint:[NSLayoutConstraint
                              constraintWithItem:topView
                              attribute:NSLayoutAttributeBottom
                              relatedBy:NSLayoutRelationEqual
                              toItem:bottomView
                              attribute:NSLayoutAttributeTop
                              multiplier:1
                              constant:dist]];
}

-(void)addHorizontalSpaceBetweenLeftView:(UIView *)leftView andRightView:(UIView *)rightView withDistance:(CGFloat)dist  {
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:leftView
                         attribute:NSLayoutAttributeLeft
                         relatedBy:NSLayoutRelationEqual
                         toItem:rightView
                         attribute:NSLayoutAttributeRight
                         multiplier:1
                         constant:dist]];
}

-(void)updateHeightConstraint:(CGFloat)newHeight{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *constraint = [self heightConstraint];
    
    if(constraint != nil){
        constraint.constant = newHeight;
    } else {
        [self pinHeightWithValue:newHeight];
    }
}

-(void)updateWidthConstraint:(CGFloat)newWidth{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *constraint = [self widthConstraint];
    
    if(constraint != nil){
        constraint.constant = newWidth;
    } else {
        [self pinWidthWithValue:newWidth];
    }
}

-(NSLayoutConstraint*)widthConstraint{
    for(NSLayoutConstraint *constraint in self.constraints){
        if(constraint.firstAttribute == NSLayoutAttributeWidth && constraint.secondAttribute == NSLayoutAttributeNotAnAttribute){
            return constraint;
        }
    }
    return nil;
}

-(NSLayoutConstraint*)heightConstraint{
    for(NSLayoutConstraint *constraint in self.constraints){
        if(constraint.firstAttribute == NSLayoutAttributeHeight && constraint.secondAttribute == NSLayoutAttributeNotAnAttribute){
            return constraint;
        }
    }
    return nil;
}
       
#pragma mark - Clear conflicting constraints.

-(void)removeHeightConstraints{
    NSArray *allConstraints = self.constraints;
    for(NSLayoutConstraint *constraint in allConstraints){
        if(constraint.firstAttribute == NSLayoutAttributeHeight && constraint.secondAttribute == NSLayoutAttributeNotAnAttribute){
            [self removeConstraint:constraint];
        }
    }
}

-(void)removeWidthConstraints{
    NSArray *allConstraints = self.constraints;
    for(NSLayoutConstraint *constraint in allConstraints){
        if(constraint.firstAttribute == NSLayoutAttributeWidth && constraint.secondAttribute == NSLayoutAttributeNotAnAttribute){
            [self removeConstraint:constraint];
        }
    }
}

-(void)clearCenterXConstraintsForSubview:(UIView*)subview{
    for(NSLayoutConstraint *constraint in self.constraints){
            if(constraint.firstAttribute == NSLayoutAttributeCenterX && constraint.secondAttribute == NSLayoutAttributeCenterX){
                [self removeConstraint:constraint]; 
            }
    }
}
       
-(void)clearLeadingEdgeConstraintsForSubview:(UIView*)subview{
    for(NSLayoutConstraint *constraint in self.constraints){
        if([constraint.firstItem isEqual:subview]){ 
            if(constraint.firstAttribute == NSLayoutAttributeLeading && constraint.secondAttribute == NSLayoutAttributeLeading){
                [self removeConstraint:constraint];
                return;
            }
        }
    }
}

-(void)clearTrailingEdgeConstraintsForSubview:(UIView*)subview{
    for(NSLayoutConstraint *constraint in self.constraints){
        if([constraint.firstItem isEqual:subview]){
            if(constraint.firstAttribute == NSLayoutAttributeTrailing && constraint.secondAttribute == NSLayoutAttributeTrailing){
                [self removeConstraint:constraint];
                return;
            }
        }
    }
}

#pragma mark - 

-(void)setCompressable:(BOOL)compressable{
    [self setHorizontallyCompressable:compressable];
    [self setVerticallyCompressable:compressable];
}

-(void)setHugsContent:(BOOL)hugsContent{
    [self setHugsContentHorizontally:hugsContent];
    [self setHugsContentVertically:hugsContent];
}

-(void)setHorizontallyCompressable:(BOOL)isCompressable{
    UILayoutPriority compressibility = (isCompressable == YES)?UILayoutPriorityDefaultLow:UILayoutPriorityDefaultHigh;
    [self setContentCompressionResistancePriority:compressibility forAxis:UILayoutConstraintAxisHorizontal];
}

-(void)setVerticallyCompressable:(BOOL)isCompressable{ 
    UILayoutPriority compressibility = (isCompressable == YES)?UILayoutPriorityDefaultLow:UILayoutPriorityDefaultHigh;
    [self setContentCompressionResistancePriority:compressibility forAxis:UILayoutConstraintAxisVertical];
}

-(void)setHugsContentHorizontally:(BOOL)hugsContent{
    UILayoutPriority huggingPriority = (hugsContent == YES)?UILayoutPriorityDefaultLow:UILayoutPriorityDefaultHigh;
    [self setContentHuggingPriority:huggingPriority forAxis:UILayoutConstraintAxisHorizontal];
}

-(void)setHugsContentVertically:(BOOL)hugsContent{
    UILayoutPriority huggingPriority = (hugsContent == YES)?UILayoutPriorityDefaultLow:UILayoutPriorityDefaultHigh;
    [self setContentHuggingPriority:huggingPriority forAxis:UILayoutConstraintAxisVertical];
}

@end
