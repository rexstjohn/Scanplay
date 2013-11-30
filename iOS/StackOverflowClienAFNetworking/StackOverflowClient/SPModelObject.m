//
//  SPModelObject.m
//  StackOverflowClient
//
//  Created by Rex St. John on 11/16/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import "SPModelObject.h"
#import "NSString+StripHTML.h"

@implementation SPModelObject

-(void)setValue:(id)value forKey:(NSString *)key{
    if([value isKindOfClass:[NSString class]]){
        NSString *stringValue = (NSString*)value;
        if([NSURL URLWithString:stringValue] == nil){
            NSString *strippedString = [NSString stringByStrippingHTMLString:stringValue];
            [super setValue:strippedString forKey:key];
        } else {
            [super setValue:stringValue forKey:key];
        }
    } else {
        [super setValue:value forKey:key];
    }
}

@end
