//
//  UIView+SimpleSizing.h
//  EatAGram
//
//  Created by Rex St John on 2/7/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SimpleSizing)

-(void)setFrameX:(CGFloat)x;
-(void)setFrameY:(CGFloat)y;
-(CGFloat)frameX;
-(CGFloat)frameY;
-(void)setSizeWidth:(CGFloat)width;
-(void)setSizeHeight:(CGFloat)height;
-(CGFloat)sizeWidth;
-(CGFloat)sizeHeight;
-(void)setFramePosition:(CGPoint)position;
@end
