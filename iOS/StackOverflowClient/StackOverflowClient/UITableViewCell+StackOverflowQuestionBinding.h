//
//  UITableViewCell+StackOverflowQuestionBinding.h
//  StackOverflowClient
//
//  Purpose of binding categories is to remove reliance on the model in the table view controller.
//
//  Created by Rex St. John on 11/16/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPStackOverflowQuestion;

@interface UITableViewCell (StackOverflowQuestionBinding)
-(void)bind:(SPStackOverflowQuestion*)question atIndexPath:(NSIndexPath*)indexPath;
@end
