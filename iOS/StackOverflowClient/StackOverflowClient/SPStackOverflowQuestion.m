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
        if(answer.is_accepted){
            self.hasAcceptedAnswer = YES;
        }
        [answerObjects addObject:answer];
    }
    // Set ascending:NO so that "YES" would appear ahead of "NO"
    NSSortDescriptor *boolDescr = [[NSSortDescriptor alloc] initWithKey:@"is_accepted" ascending:NO];
    NSArray *sortDescriptors = @[boolDescr];
    NSArray *sortedArray = [answerObjects sortedArrayUsingDescriptors:sortDescriptors];
    
    _answers = [NSArray arrayWithArray:sortedArray];
}

@end
