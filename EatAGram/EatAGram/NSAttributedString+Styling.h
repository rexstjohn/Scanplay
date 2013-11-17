//
//  NSAttributedString+Styling.h
//  EatAGram
//
//  Created by Rex St John on 1/17/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Styling)

+(NSAttributedString*)stringWithColor:(UIColor*)color forRange:(NSRange)range;

@end
