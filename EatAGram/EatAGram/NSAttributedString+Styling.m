//
//  NSAttributedString+Styling.m
//  EatAGram
//
//  Created by Rex St John on 1/17/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "NSAttributedString+Styling.h"
#import <CoreText/CoreText.h>

@implementation NSAttributedString (Styling)

+(NSAttributedString*)stringWithColor:(UIColor*)color forRange:(NSRange)range{
    NSMutableAttributedString *mutAttrStr = [[NSMutableAttributedString alloc]init];
    [mutAttrStr addAttribute:(NSString*)kCTForegroundColorAttributeName
                   value:(id)[color CGColor]
                   range:range];
    return mutAttrStr;
}

@end
