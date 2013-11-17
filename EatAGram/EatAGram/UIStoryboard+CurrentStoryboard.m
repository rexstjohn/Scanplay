//
//  UIStoryboard+CurrentStoryboard.m
//  EatAGram
//
//  Created by Rex St John on 1/13/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "UIStoryboard+CurrentStoryboard.h"
#import "UIStoryboard+storyboardWithUniversalName.h"

@implementation UIStoryboard (CurrentStoryboard)

+(UIStoryboard*)currentStoryboard{
    UIStoryboard *storyboard;
    storyboard = [UIStoryboard storyboardWithUniversalName:kHomeStoryboardName
                                                    bundle:nil];
    return storyboard;
}

+(UIViewController*)createFromClass:(Class)claz inStoryboardWithUniversalName:(NSString*)storyboarUniversalName{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithUniversalName:storyboarUniversalName
                                                                               bundle:nil];
    UIViewController *targetVc = [storyboard instantiateViewControllerWithIdentifier:[claz description]];
    return targetVc;
}

+(UIViewController*)createFromClass:(Class)claz inStoryboardWithName:(NSString*)storyboardName specificToIdiom:(UIUserInterfaceIdiom)targetIdiom{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName andInterfaceIdiom:targetIdiom bundle:nil];
    UIViewController *targetVc = [storyboard instantiateViewControllerWithIdentifier:[claz description]];
    return targetVc;
}

@end
