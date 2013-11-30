//
//  NSArray+StackOverflowQuestions.h
//  StackOverflowClient
//
//  Created by Rex St. John on 11/15/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (StackOverflowQuestions)

// Renders JSON into SPStackOverflowQuestion objects.
+ (NSArray *)questionsArrayFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end
