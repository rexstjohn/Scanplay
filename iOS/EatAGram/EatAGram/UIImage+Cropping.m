//
//  UIImage+Cropping.m
//  EatAGram
//
//  Created by Rex St John on 3/24/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "UIImage+Cropping.h"

@implementation UIImage (Cropping)

-(UIImage*)croppedToRect:(CGRect)cropRect{  
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], cropRect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}

-(UIImage*)croppedImageInScrollView:(UIScrollView *)scrollView{
    // Math for cropping a zoomed image in a scrollview.
    float scale = 1.0f/scrollView.zoomScale;
    CGRect visibleRect;
    visibleRect.origin.x = scrollView.contentOffset.x * scale;
    visibleRect.origin.y = scrollView.contentOffset.y * scale;
    visibleRect.size.width = scrollView.bounds.size.width * scale;
    visibleRect.size.height = scrollView.bounds.size.height * scale;
    
    CGImageRef croppedImageRef = CGImageCreateWithImageInRect([self CGImage],visibleRect);
    UIImage* cropped = [[UIImage alloc] initWithCGImage:croppedImageRef];
    CGImageRelease(croppedImageRef);
    return cropped;
}
@end
