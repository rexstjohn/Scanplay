//
//  LevelLoader.h
//  Flywheels
//
//  Created by Rexford St. John on 6/20/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SPPhysicsContext;
@class SPPhysicsLibrary;
@class SPPhysicsFactory;

#define OBJECTS_KEY @"objects"
#define OBJECT_KEY  @"object"

@interface SPLevelLoader : NSObject
// init with a context
-(id) initWithContext:(SPPhysicsContext*)aContext andLibrary:(SPPhysicsLibrary*)aLibrary;

// produces a Objects from an XML file.
-(void) loadObjectsFromXMLFile:(NSString*)filename;

@property(nonatomic,retain) SPPhysicsContext *context;
@property(nonatomic,retain) SPPhysicsLibrary *library;
@property(nonatomic,retain) SPPhysicsFactory *factory;

@end
