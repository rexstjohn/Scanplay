//
//  SPStackOverflowNetworkingEngine.h
//  StackOverflowClient
//
//  MKNetworkingKit based network engine for StackExchange api queries
//
//  Created by Rex St. John on 11/15/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import "MKNetworkEngine.h"
@class SPStackOverflowQuestion;

@interface SPStackOverflowNetworkingEngine : MKNetworkEngine

typedef void (^StackOverflowQuestionsResponseBlock)(NSArray *questions);
typedef void (^StackOverflowQuestionResponseBlock)(SPStackOverflowQuestion *question);

// Get questions with a list of parameters.
-(MKNetworkOperation*) questionsWithParameters:(NSDictionary*)parameters
                              completionHandler:(StackOverflowQuestionsResponseBlock)completion
                                  errorHandler:(MKNKErrorBlock)error;

// Get a single question with a question ID.
-(MKNetworkOperation*) questionWithQuestionId:(NSNumber*)questionId
                               withParameters:(NSDictionary*)parameters
                             completionHandler:(StackOverflowQuestionResponseBlock)completion
                                  errorHandler:(MKNKErrorBlock)error;

@end
