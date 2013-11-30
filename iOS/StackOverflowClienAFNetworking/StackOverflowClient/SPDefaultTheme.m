//
//  SPDefaultTheme.m
//  StackOverflowClient
//
//  Created by Rex St. John on 11/16/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import "SPDefaultTheme.h"

@implementation SPDefaultTheme

- (void)themeQuestionTableViewCell:(UITableViewCell*)cell{
    [cell setBackgroundColor:[UIColor colorWithRed:250.0f/255.0f green:250.0f/255.0f blue:210.0f/255.0f alpha:1.0]];
}

- (void)themeAnswerTableViewCell:(UITableViewCell*)cell{
    [cell setBackgroundColor:[UIColor colorWithRed:100.0f/255.0f green:149.0f/255.0f blue:237.0f/255.0f alpha:1.0]];
}

- (void)themeQuestionFooterButton:(UIButton*)button{ 
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

- (void)themeTitleLabel:(UILabel*)label{
    label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

- (void)themeBodyLabel:(UILabel*)label{
    label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

- (void)themeBodyTextView:(UITextView*)textView{
    textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    [textView setBackgroundColor:[UIColor clearColor]];
}

@end
