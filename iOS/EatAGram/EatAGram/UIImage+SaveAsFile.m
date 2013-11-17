//
//  UIImage+SaveAsFile.m
//  EatAGram
//
//  Created by Rex St John on 4/10/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "UIImage+SaveAsFile.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ALAssetsLibrary+CustomPhotoAlbum.h"

@implementation UIImage (SaveAsFile)

-(void)saveToPNGFile{
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(self)];
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    [imageData writeToFile:documentsDirectory atomically:YES];
}

-(void)saveToJPGFile{
    NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(self, 1)];
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    [imageData writeToFile:documentsDirectory atomically:YES];
}

-(void)saveAsJPGToDocumentsDirectoryWithFileName:(NSString*)fileName{
    // Create paths to output images
    NSString *path = [NSString stringWithFormat:@"Documents/%@", fileName];
    NSString  *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:path];
    
    // Write a UIImage to JPEG with minimum compression (best quality)
    // The value 'image' must be a UIImage object
    // The value '1.0' represents image compression quality as value from 0.0 to 1.0
    [UIImageJPEGRepresentation(self, 1.0) writeToFile:jpgPath atomically:YES];
    
    // Create file manager
    NSError *error;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    // Point to Document directory
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    // Write out the contents of home directory to console
    NSLog(@"Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]);
}

-(void)saveAsPNGToDocumentsDirectoryWithFileName:(NSString*)fileName{
    
    NSString *path = [NSString stringWithFormat:@"Documents/%@", fileName];
    // Create paths to output images
    NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:path];
    
    // Write image to PNG
    [UIImagePNGRepresentation(self) writeToFile:pngPath atomically:YES];
    
    // Let's check to see if files were successfully written...
    
    // Create file manager
    NSError *error;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    // Point to Document directory
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    // Write out the contents of home directory to console
    NSLog(@"Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]);
}

+(void)saveImage:(UIImage*)image toAlbum:(NSString *)album{
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library saveImage:image toAlbum:album withCompletionBlock:^(NSError *error) {
        if (error!=nil) {
            NSLog(@"Big error: %@", [error description]);
        }
    }];
}

+(void)largeImageWithPath:(NSString*)path{
    
    NSString *mediaurl = path;
    __block UIImage *largeImage;
    
    //
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *rep = [myasset defaultRepresentation];
        CGImageRef iref = [rep fullResolutionImage];
        if (iref) {
            largeImage = [UIImage imageWithCGImage:iref]; 
        }
    };
    
    //
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
    {
        NSLog(@"booya, cant get image - %@",[myerror localizedDescription]);
    };
    
    if(mediaurl && [mediaurl length] && ![[mediaurl pathExtension] isEqualToString:@".png"])
    { 
        NSURL *asseturl = [NSURL URLWithString:mediaurl];
        ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
        [assetslibrary assetForURL:asseturl
                       resultBlock:resultblock
                      failureBlock:failureblock];
    }
}

@end
