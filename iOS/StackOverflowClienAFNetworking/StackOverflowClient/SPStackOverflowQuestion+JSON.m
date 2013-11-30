//
//  SPStackOverflowQuestion+JSON.m
//  StackOverflowClient
//
//  Created by Rex St. John on 11/16/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import "SPStackOverflowQuestion+JSON.h"
#import "SPStackOverflowQuestion.h"

@implementation SPStackOverflowQuestion (JSON)

+ (SPStackOverflowQuestion *)questionFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    NSArray *results = [parsedObject valueForKey:@"items"];
    
    SPStackOverflowQuestion *question = [[SPStackOverflowQuestion alloc] init];
    
    if(results.count == 0 || results == nil){
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"Question Not Found" forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:@"SPStackOverflowQuestion" code:200 userInfo:details];
        return nil;
    }
    
    for (NSDictionary *questionsDic in results) {
        for (NSString *key in questionsDic) {
            if ([question respondsToSelector:NSSelectorFromString(key)]) {
                [question setValue:[questionsDic valueForKey:key] forKey:key];
            }
        }
    }
    
    return question;
}
@end
