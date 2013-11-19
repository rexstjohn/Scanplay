//
//  SPStackOverflowQuestion+JSON.h
//  StackOverflowClient
//
//  Created by Rex St. John on 11/16/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import "SPStackOverflowQuestion.h"

@interface SPStackOverflowQuestion (JSON)

// Renders a question from JSON.
+ (SPStackOverflowQuestion *)questionFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end
