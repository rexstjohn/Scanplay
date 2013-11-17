//
//  UITableViewCell+StackOverflowQuestionBinding.m
//  StackOverflowClient
//
//  Created by Rex St. John on 11/16/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import "UITableViewCell+StackOverflowQuestionBinding.h"
#import "SPStackOverflowQuestion.h"

@implementation UITableViewCell (StackOverflowQuestionBinding)

-(void)bind:(SPStackOverflowQuestion*)question atIndexPath:(NSIndexPath*)indexPath{
    
    UILabel *titleLabel = (UILabel*)[self viewWithTag:10];
    titleLabel.text = [NSString stringWithFormat:@"#%i %@",indexPath.row+1,question.title];
    
    UITextView *bodyTextView = (UITextView*)[self viewWithTag:11];
    bodyTextView.text = question.body;
    
    UILabel *detailsLabel = (UILabel*)[self viewWithTag:12];
    NSString *isAnswered = (question.hasAcceptedAnswer == YES)?@"YES":@"NO";
    detailsLabel.text = [NSString stringWithFormat:@"Answers: %i Accepted? %@", question.answers.count, isAnswered ];
    [detailsLabel setBackgroundColor:[UIColor whiteColor]];
    
    // Example exclusion zone.
    UIImageView *imageView = (UIImageView*)[self viewWithTag:13];
    UIBezierPath* exclusionPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(imageView.center.x-10.0f, imageView.center.y-80.0f)
                                                                 radius:(MAX(imageView.frame.size.width, imageView.frame.size.height) * 0.5 + 20.0f)
                                                             startAngle:-180.0f
                                                               endAngle:180.0f
                                                              clockwise:YES];
    bodyTextView.textContainer.exclusionPaths  = @[exclusionPath];
    
    // Apply theme.
    [[SPThemeResolver theme] themeQuestionTableViewCell:self];
    [[SPThemeResolver theme] themeTitleLabel:titleLabel];
    [[SPThemeResolver theme] themeBodyLabel:detailsLabel];
    [[SPThemeResolver theme] themeBodyTextView:bodyTextView];
}

@end
