//
//  NSArray+FileSerialization.h
//  EatAGram
//
//  Convenience methods for storing and loading an array to and from a file directory.
//
//  Created by Rex St John on 2/5/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (FileSerialization)

-(void)archiveToPath:(NSSearchPathDirectory)fileDirectory withFileName:(NSString*)fileName;

+(BOOL)archiveExistsAtPath:(NSSearchPathDirectory)fileDirectory withFileName:(NSString*)fileName;

+(NSArray*)arrayWithContentsFromDirectory:(NSSearchPathDirectory)fileDirectory andFileName:(NSString*)fileName;

@end
