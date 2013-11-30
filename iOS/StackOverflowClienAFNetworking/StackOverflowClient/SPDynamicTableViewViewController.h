//
//  SPDynamicTableViewViewController.h
//  StackOverflowClient
//
//  Created by Rex St. John on 11/15/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPDynamicTableViewViewController : UITableViewController

// Used to calculate the frame used by a text view.
-(CGSize)frameForText:(NSString*)text sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size;

// Array of body texts used for sizing the table cells.
@property(nonatomic,strong) NSArray *bodyTextArray;

// Array of title texts for resizing the table sells.
@property(nonatomic,strong) NSArray *titleArray;

@property (nonatomic,strong, readonly) UIFont *fontForTitleLabel;
@property (nonatomic,strong, readonly) UIFont *fontForBodyTextView;

@end
