//
//  SPThemeResolver.m
//  StackOverflowClient
//
//  Created by Rex St. John on 11/16/13.
//  Copyright (c) 2013 Rex St. John. All rights reserved.
//

#import "SPThemeResolver.h"
#import "SPDefaultTheme.h"

static NSMutableDictionary* _themes;

@implementation SPThemeResolver

static NSString* const kThemeKey = @"theme";
static NSString* const kDefaultThemeKey = @"default";
static NSString* const kOtherThemeKey = @"other";

+ (id<SPTheme>)theme {
    NSString* themeName = kDefaultThemeKey;
    id<SPTheme> theme = [_themes objectForKey:themeName];
    if(_themes == nil){
        _themes = [[NSMutableDictionary alloc] init];
    }
    if(theme == nil) {
        if([themeName isEqualToString:kDefaultThemeKey]) {
            theme = [[SPDefaultTheme alloc] init];
        } else if([themeName isEqualToString:kOtherThemeKey]) {
            theme = [[SPDefaultTheme alloc] init];
        } else {
            //
        }
        [_themes setValue:theme forKey:themeName];
    }
    return theme;
}

@end
