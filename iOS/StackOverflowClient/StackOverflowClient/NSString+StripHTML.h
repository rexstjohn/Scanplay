//
//  NSString+StripHTML.h
//  StackOverflowClient
//
//  Created by Rex St. John on 11/16/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StripHTML)

// Forcefully strips out HTML text from the question information.
+(NSString *)stringByStrippingHTMLString:(NSString *)html;

@end
