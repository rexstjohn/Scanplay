//
//  SPTheme.h
//  StackOverflowClient
//
//  Created by Rex St. John on 11/16/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPTheme

@required
- (void)themeQuestionTableViewCell:(UITableViewCell*)cell;
- (void)themeAnswerTableViewCell:(UITableViewCell*)cell;
- (void)themeQuestionFooterButton:(UIButton*)button;
- (void)themeTitleLabel:(UILabel*)label;
- (void)themeBodyLabel:(UILabel*)label;
- (void)themeBodyTextView:(UITextView*)textView;
@optional
// Theming UITableView
- (void)themeTableView:(UITableView*)tableView;
- (void)themeTableCellTitle:(UILabel*)titleLabel;
- (void)themeTableCellSubTitle:(UILabel*)subTitleLabel;
// Theming general UI Controls
- (void)themeProfileImage:(UIImageView*)imageView;
- (void)themeViewBackground:(UIView*)view;
@end