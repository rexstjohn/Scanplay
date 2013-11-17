//
//  UIView+RelativeLayouts.m
//  EatAGram
//
//  Created by Rex St John on 2/26/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "UIView+RelativeLayouts.h"
#import "UIView+SimpleSizing.h"

@implementation UIView (RelativeLayouts)

+(void)layoutViews:(NSArray*)views withSpacing:(CGFloat)spacing atPoint:(CGPoint)startingPoint{
    
    NSAssert(views.count > 1, @"You must have more than one view to layout!");
    
    UIView *priorView = views[0];
    [priorView setFramePosition:startingPoint];
         
    for(int i = 1; i < views.count; i++){
        UIView *nextView = views[i];
        [nextView layoutBelowView:priorView withSpacing:spacing];
        priorView = nextView;
    }
}

-(void)layoutBelowView:(UIView*)topView withSpacing:(CGFloat)spacing{
    [self setFrameY:[topView frameY] + [topView sizeHeight] + spacing];
}
@end
