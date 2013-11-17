//
//  UITableView+CellVisibility.h
//  EatAGram
//
//  Created by Rex St John on 2/6/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (CellVisibility)

-(CGRect)visibleRectForCellAtIndexPath:(NSIndexPath*)indexPath;
-(BOOL)cellIndexPath:(NSIndexPath*)cellAIndexPath isMoreVisibleThanCellAtIndexPath:(NSIndexPath*)cellBIndexPath;
    
@end
