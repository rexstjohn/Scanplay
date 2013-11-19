//
//  SPAnswerTableViewController.h
//  StackOverflowClient
//
//  Created by Rex St. John on 11/15/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPDynamicTableViewViewController.h"
@class SPStackOverflowQuestion;

@interface SPAnswerTableViewController : SPDynamicTableViewViewController

//
@property(nonatomic,strong, readonly) NSArray *answers;

//
@property(nonatomic,strong) SPStackOverflowQuestion *question;

@end
