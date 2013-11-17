//
//  UITextView+Clipping.m
//  EatAGram
//
//  Created by Rex St John on 4/18/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "UITextView+Clipping.h"

@implementation UITextView (Clipping)

+(NSString *)truncatedTextForString:(NSString *)inputString withFont:(UIFont *)font withLength:(int)textViewlength
{
    
    CGSize dotSize=[@"..." sizeWithFont:font];
    float dotWidth=dotSize.width;
    NSString *outputString=@"";
    
    int reqLength=textViewlength-dotWidth;
    
    for(int i=0;i<inputString.length;i++)
    {
        
        NSString *tempStr=[outputString stringByAppendingString:[inputString substringWithRange:NSMakeRange(i,1)]];
        
        if([tempStr sizeWithFont:font].width>reqLength)
        {
            break;
        }
        else
        {
            outputString=tempStr;
        }
    }
    NSString *tempStr=[outputString stringByAppendingString:@"..."];
    outputString=tempStr;
    return outputString; 
}
@end
