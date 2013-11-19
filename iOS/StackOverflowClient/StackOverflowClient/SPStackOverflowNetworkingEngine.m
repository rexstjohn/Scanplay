//
//  SPStackOverflowNetworkingEngine.m
//  StackOverflowClient
//
//  Created by Rex St. John on 11/15/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import "SPStackOverflowNetworkingEngine.h" 
#import "NSArray+StackOverflowQuestions.h"
#import "SPStackOverflowQuestion.h"
#import "SPStackOverflowQuestion+JSON.h"

@implementation SPStackOverflowNetworkingEngine

-(MKNetworkOperation*) questionsWithParameters:(NSDictionary*)parameters
                              completionHandler:(StackOverflowQuestionsResponseBlock)completion
                                   errorHandler:(MKNKErrorBlock)errorBlock {
    
    static NSString *queryPath = @"/2.1/search";
    MKNetworkOperation *op = [self operationWithPath:queryPath
                                              params:parameters
                                          httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     { 
         NSError *error = nil;
         NSArray *values = [NSArray questionsArrayFromJSON:[completedOperation responseData] error:&error];
         
         if(error == nil){
             completion(values);
         } else{
             errorBlock(error);
         }
         
     }errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         errorBlock(error);
     }];
    
    [self enqueueOperation:op];
    
    return op;
}

-(MKNetworkOperation*) questionWithQuestionId:(NSNumber*)questionId
                               withParameters:(NSDictionary*)parameters
                            completionHandler:(StackOverflowQuestionResponseBlock)completion
                                 errorHandler:(MKNKErrorBlock)errorBlock{
    
    NSString *queryPath = [NSString stringWithFormat:@"/2.1/questions/%i", [questionId integerValue]];
    MKNetworkOperation *op = [self operationWithPath:queryPath
                                              params:parameters
                                          httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         NSError *error = nil;
         SPStackOverflowQuestion *value = [SPStackOverflowQuestion questionFromJSON:[completedOperation responseData] error:&error];
         
         if(error == nil){
             completion(value);
         } else{
             errorBlock(error);
         }
         
     }errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         errorBlock(error);
     }];
    
    [self enqueueOperation:op];
    
    return op;
}

@end
