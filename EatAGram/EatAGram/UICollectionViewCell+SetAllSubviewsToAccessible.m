//
//  UICollectionViewCell+SetAllSubviewsToAccessible.m
//  EatAGram
//
//  Created by Jason Cross on 5/22/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "UICollectionViewCell+SetAllSubviewsToAccessible.h"

@implementation UICollectionViewCell (SetAllSubviewsToAccessible)

- (void)internalSetAllSubViewsToAccessible:(UIView*)parentView {
    if (parentView.subviews.count > 0) {
        for (UIView * view in parentView.subviews) {
            [self internalSetAllSubViewsToAccessible:view];
        }
    }
    else {
        parentView.isAccessibilityElement = YES;
    }
}

- (void)setAllSubViewsToAccessible {
    self.isAccessibilityElement = NO;
    for (UIView * view in self.contentView.subviews) {
        [self internalSetAllSubViewsToAccessible:view];
    }
}

@end
