//
//  UIImage+Frame.h
//  EatAGram
//
//  Draws a frame directly onto an Image.
//
//  Created by Rex St John on 3/26/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Frame)

-(UIImage*)imageWithFrameColor:(UIColor*)color andWidth:(CGFloat)frameWidth;

@end
