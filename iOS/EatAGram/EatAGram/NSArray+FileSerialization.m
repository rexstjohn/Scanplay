//
//  NSArray+FileSerialization.m
//  EatAGram
//
//  Created by Rex St John on 2/5/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "NSArray+FileSerialization.h"

@implementation NSArray (FileSerialization)

-(void)archiveToPath:(NSSearchPathDirectory)fileDirectory withFileName:(NSString*)fileName{
    // NSDocumentDirectory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(fileDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *fullFileName = [NSString stringWithFormat:@"%@/%@", docDir, fileName];
    [NSKeyedArchiver archiveRootObject:self toFile:fullFileName];
}

+(BOOL)archiveExistsAtPath:(NSSearchPathDirectory)fileDirectory withFileName:(NSString*)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(fileDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *fullFileName = [NSString stringWithFormat:@"%@/%@", docDir, fileName];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    BOOL fileExists = [fileManager fileExistsAtPath:fullFileName];
    return fileExists;
}

+(NSArray*)arrayWithContentsFromDirectory:(NSSearchPathDirectory)fileDirectory andFileName:(NSString*)fileName{
    // NSDocumentDirectory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(fileDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *fullFileName = [NSString stringWithFormat:@"%@/%@", docDir, fileName];
    NSMutableArray *arrayFromDisk = [NSKeyedUnarchiver unarchiveObjectWithFile:fullFileName];
    return [[NSArray alloc]initWithArray:arrayFromDisk];
}

@end
