//
//  UIStoryboard+storyboardWithUniversalName.m
//  EatAGram
//
//  Created by JASON CROSS on 3/8/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "UIStoryboard+storyboardWithUniversalName.h"

@implementation UIStoryboard (storyboardWithUniversalName)

+ (UIStoryboard*) storyboardWithUniversalName:(NSString*)universalName bundle:(NSBundle *)storyboardBundleOrNil {
    
    // first check to see if the storyboard file we want exists. If it does not, then assume that the
    // universally-named file does exist
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:universalName
                                                          bundle:storyboardBundleOrNil];
    if (nil == storyboardBundleOrNil) {
        NSString * suffix = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? @"~ipad" : @"~iphone";
        NSString * name = [NSString stringWithFormat:@"%@%@", universalName, suffix];
        storyboard = [UIStoryboard storyboardWithName:name bundle:storyboardBundleOrNil];
    }
    return storyboard;
}

+ (UIStoryboard*) storyboardWithName:(NSString*)universalName andInterfaceIdiom:(UIUserInterfaceIdiom)targetIdiom bundle:(NSBundle *)storyboardBundleOrNil {
    
    // first check to see if the storyboard file we want exists. If it does not, then assume that the
    // universally-named file does exist
    UIStoryboard * storyboard;
        NSString * suffix = (targetIdiom == UIUserInterfaceIdiomPad) ? @"~ipad" : @"~iphone";
        NSString * name = [NSString stringWithFormat:@"%@%@", universalName, suffix];
        storyboard = [UIStoryboard storyboardWithName:name bundle:storyboardBundleOrNil]; 
    return storyboard;
}

@end
