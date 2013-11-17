//
//  UIImageView+AsyncLoading.h
//  EatAGram
//
//  This is a special image view loading type that displays a placeholder image and spinner while performing
//  an async image download from a list or other view.
//
//  Created by Rex St John on 1/18/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (AsyncLoading)

-(void)downloadImageFromUrl:(NSURL*)url withPlaceholderNamed:(NSString*)placeholderImageName;

@end
