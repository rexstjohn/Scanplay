//
//  UIImage+Resize.m
//  EatAGram
//
//  Created by Jason Cross on 5/14/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

- (CGRect)rectForImageResizedToSize:(CGSize)size {
    CGRect imageRect = {{0.0, 0.0}, self.size};
    CGFloat scale = 1.0;
    if(CGRectGetWidth(imageRect) > CGRectGetHeight(imageRect)) {
        scale = size.width / CGRectGetWidth(imageRect);
    } else {
        scale = size.height / CGRectGetHeight(imageRect);
    }
    
    CGRect rect = CGRectMake(0.0, 0.0,
                             scale * CGRectGetWidth(imageRect),
                             scale * CGRectGetHeight(imageRect));
    rect.origin.x = (size.width - CGRectGetWidth(rect)) / 2.0;
    rect.origin.y = (size.height - CGRectGetHeight(rect)) / 2.0;
    return rect;
}

- (UIImage*) resizeImageToSize:(CGSize)cellViewSize; {
    CGRect cellViewRect = [self rectForImageResizedToSize:cellViewSize];
    UIGraphicsBeginImageContext(cellViewSize);
    [self drawInRect:cellViewRect];
    UIImage * resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
}

@end
