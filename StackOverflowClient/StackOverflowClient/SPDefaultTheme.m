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
    [cell setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)themeAnswerTableViewCell:(UITableViewCell*)cell{
    [cell setBackgroundColor:[UIColor blueColor]];
}

- (void)themeQuestionFooterButton:(UIButton*)button{ 
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
}

@end
