//
//  UITableView+CellVisibility.m
//  EatAGram
//
//  Created by Rex St John on 2/6/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "UITableView+CellVisibility.h"

@implementation UITableView (CellVisibility)

-(CGRect)visibleRectForCellAtIndexPath:(NSIndexPath*)indexPath{
    CGRect cellRect = [self rectForRowAtIndexPath:indexPath];
    cellRect = [self convertRect:cellRect toView:self.superview];
    
    BOOL isVisible = CGRectIntersectsRect(self.frame, cellRect);
    
    CGRect visibleRect = CGRectZero;
    if(isVisible == YES){
        visibleRect = CGRectIntersection(cellRect, self.frame);
    }
    
    return visibleRect;
}

-(BOOL)cellIndexPath:(NSIndexPath*)cellAIndexPath isMoreVisibleThanCellAtIndexPath:(NSIndexPath*)cellBIndexPath{
    CGRect rectForCellA = [self visibleRectForCellAtIndexPath:cellAIndexPath];
    CGRect rectForCellB = [self visibleRectForCellAtIndexPath:cellBIndexPath];
    BOOL isMoreVisible = (rectForCellA.size.height > rectForCellB.size.height);
    return isMoreVisible;
}

@end
