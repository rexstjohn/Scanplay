//
//  NSObject+USPGeneralizedNullCheck.m
//  EatAGram
//
//  Created by JASON CROSS on 1/18/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "NSObject+USPGeneralizedNullCheck.h"

@implementation NSObject (USPGeneralizedNullCheck)

+ (BOOL) isEmpty: (id) thing;{
    return (thing == nil) || (thing == [NSNull null])
    || ([thing respondsToSelector:@selector(length)] && ([(NSData *)thing length] == 0))
    || ([thing respondsToSelector:@selector(count)] && ([(NSArray *)thing count] == 0));
}

@end
