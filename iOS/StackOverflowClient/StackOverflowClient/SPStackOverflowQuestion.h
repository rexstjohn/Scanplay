//
//  SPStackOverflowQuestion.h
//  StackOverflowClient
//
//  Basic dummy object representing a stack overflow question.
//
//  Created by Rex St. John on 11/15/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPModelObject.h"

@interface SPStackOverflowQuestion : SPModelObject
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSURL *link;
@property(nonatomic,copy) NSNumber *question_id;
@property(nonatomic,copy) NSString *body;
@property(nonatomic,assign) BOOL is_answered;
@property(nonatomic,assign) BOOL hasAcceptedAnswer;
@property(nonatomic,strong) NSArray *answers;
@end
