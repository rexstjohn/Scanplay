//
//  UIImage+SaveAsFile.h
//  EatAGram
//
//  Created by Rex St John on 4/10/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SaveAsFile)

-(void)saveToPNGFile;
-(void)saveToJPGFile;
-(void)saveAsJPGToDocumentsDirectoryWithFileName:(NSString*)fileName;
-(void)saveAsPNGToDocumentsDirectoryWithFileName:(NSString*)fileName;
+(void)saveImage:(UIImage*)image toAlbum:(NSString *)album;
+(void)largeImageWithPath:(NSString*)path;

@end
