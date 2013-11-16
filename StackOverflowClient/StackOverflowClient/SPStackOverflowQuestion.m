//
//  SPStackOverflowQuestion.m
//  StackOverflowClient
//
//  Created by Rex St. John on 11/15/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import "SPStackOverflowQuestion.h"
#import "SPStackOverflowAnswer.h"

@implementation SPStackOverflowQuestion

-(void)setAnswers:(NSArray *)answers{
    
    NSMutableArray *answerObjects = [NSMutableArray arrayWithCapacity:answers.count];
    // Parse answers.
    for(NSDictionary *answersDic in answers){
        SPStackOverflowAnswer *answer = [[SPStackOverflowAnswer alloc] init];
        for (NSString *answerKey in answersDic){
            if ([answer respondsToSelector:NSSelectorFromString(answerKey)]) {
                [answer setValue:[answersDic valueForKey:answerKey] forKey:answerKey];
            }
        }
        [answerObjects addObject:answer];
    }
    _answers = [NSArray arrayWithArray:answerObjects];
}

@end
