//
//  UIImage+Compositing.m
//  EatAGram
//
//  Created by Rex St John on 1/28/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "UIImage+Compositing.h"

@implementation UIImage (Compositing)

+(UIImage*)compositeImage:(UIImage*)firstImage withSecondImage:(UIImage*)secondImage{
    
    CGSize newSize = CGSizeMake(44, 44);
    UIGraphicsBeginImageContext( newSize );
    
    // Use existing opacity as is
    [firstImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Apply supplied opacity if applicable
    [secondImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height) blendMode:kCGBlendModeNormal alpha:0.8];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
