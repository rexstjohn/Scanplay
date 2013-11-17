//
//  UIStoryboard+CurrentStoryboard.m
//  EatAGram
//
//  Created by Rex St John on 1/13/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "UIStoryboard+CreateFromClass.h"
#import "UIStoryboard+storyboardWithUniversalName.h"

@implementation UIStoryboard (CreateFromClass)
 
+(UIViewController*)createFromClass:(Class)claz inStoryboardWithUniversalName:(NSString*)storyboarUniversalName{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithUniversalName:storyboarUniversalName
                                                                               bundle:nil];
    UIViewController *targetVc = [storyboard instantiateViewControllerWithIdentifier:[claz description]];
    return targetVc;
}

@end
