//
//  UIImage+Compositing.h
//  EatAGram
//
//  Created by Rex St John on 1/28/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compositing)

+(UIImage*)compositeImage:(UIImage*)firstImage withSecondImage:(UIImage*)secondImage;

@end
