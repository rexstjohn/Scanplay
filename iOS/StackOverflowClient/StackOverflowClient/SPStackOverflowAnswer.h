//
//  SPStackOverflowAnswer.h
//  StackOverflowClient
//
//  Stack Overflow answer object model.
//
//  Created by Rex St. John on 11/15/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPModelObject.h"

@interface SPStackOverflowAnswer : SPModelObject
@property(nonatomic,copy) NSString *body;
@property(nonatomic,assign) BOOL is_accepted;
@end
