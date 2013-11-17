//
//  NSArray+DelimitedData.h
//  EatAGram
//
//  Created by Rex St John on 2/5/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (DelimitedString)

+(NSArray*)arrayFromDelimitedString:(NSString*)delimitedString
                  seperatedByString:(NSString*)delimiter;

+(NSArray*)arrayFromDelimitedString:(NSString*)delimitedString
                enumeratedWithBlock:(void (^)(NSString* row, NSUInteger idx, BOOL *stop))block;

+(NSArray*)arrayFromFileAtPathResource:(NSString*)filePath
                     withFileExtension:(NSString*)extensions
                     seperatedByString:(NSString*)delimiter;
@end
