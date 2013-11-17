//
//  UITextView+Clipping.h
//  EatAGram
//
//  Created by Rex St John on 4/18/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Clipping)

+(NSString *)truncatedTextForString:(NSString *)inputString withFont:(UIFont *)font withLength:(int)textViewlength;

@end
