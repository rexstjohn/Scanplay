//
//  NSArray+DelimitedData.m
//  EatAGram
//
//  Created by Rex St John on 2/5/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "NSArray+DelimitedString.h"

@implementation NSArray (DelimitedString)

+(NSArray*)arrayFromDelimitedString:(NSString*)delimitedString
                  seperatedByString:(NSString*)delimiter{
    
    NSString *content = delimitedString;
    NSArray *rows = [content componentsSeparatedByString:@"\n"];
    return rows;
}

+(NSArray*)arrayFromDelimitedString:(NSString*)delimitedString
                enumeratedWithBlock:(void (^)(NSString* row, NSUInteger idx, BOOL *stop))block {
    
    NSString *content = delimitedString;
    NSArray *rows = [content componentsSeparatedByString:@"\n"];
    [rows enumerateObjectsUsingBlock:block];
    return rows;
}

+(NSArray*)arrayFromFileAtPathResource:(NSString*)filePath
                     withFileExtension:(NSString*)extensions
                     seperatedByString:(NSString*)delimiter{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:filePath ofType:extensions];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    NSArray *rows = [content componentsSeparatedByString:@"\n"];
    return rows;
}
@end
