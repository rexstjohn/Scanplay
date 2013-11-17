//
//  UIView+ImageCapture.m
//  EatAGram
//
//  Created by Rex St John on 2/6/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "UIView+ImageCapture.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (ImageCapture)

-(UIImage*)captureViewImageAndSaveToDisk:(BOOL)saveToDisk{
    UIGraphicsBeginImageContext(self.frame.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(saveToDisk == YES){
        UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    }
    return viewImage;
}

@end
