//
//  UIFont+EnumerateFonts.m
//  EatAGram
//
//  Created by Rex St John on 1/28/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "UIFont+EnumerateFonts.h"

@implementation UIFont (EnumerateFonts)

+(void)enumerateInstalledFonts{
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
        printf( "Family: %s \n", [familyName UTF8String] );
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames ){
            printf( "\tFont: %s \n", [fontName UTF8String] );
        }
    }
}

@end
