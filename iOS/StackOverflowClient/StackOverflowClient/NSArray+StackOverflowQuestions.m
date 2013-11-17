//
//  NSArray+StackOverflowQuestions.m
//  StackOverflowClient
//
//  Created by Rex St. John on 11/15/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import "NSArray+StackOverflowQuestions.h"
#import "SPStackOverflowQuestion.h"
#import "SPStackOverflowAnswer.h"

@implementation NSArray (StackOverflowQuestions)

+ (NSArray *)questionsArrayFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *questions = [[NSMutableArray alloc] init];
    NSArray *results = [parsedObject valueForKey:@"items"];
    
    for (NSDictionary *questionsDic in results) {
        SPStackOverflowQuestion *question = [[SPStackOverflowQuestion alloc] init];
        
        for (NSString *key in questionsDic) {
            if ([question respondsToSelector:NSSelectorFromString(key)]) {
                [question setValue:[questionsDic valueForKey:key] forKey:key];
            }
        }
        
        [questions addObject:question];
    }
    
    return questions;
}
@end
