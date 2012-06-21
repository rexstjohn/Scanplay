//
//  LevelLoader.m
//  Flywheels
//
//  Created by Rexford St. John on 6/20/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "SPLevelLoader.h"
#import "SPPhysicsContext.h"
#import "SMXMLDocument.h"
#import "SPPhysicsLibrary.h"
#import "SPPhysicsPrefab.h"
#import "Utils.h"

// The purpose of this class is to provide a rapid method for loading levels.
@implementation SPLevelLoader

@synthesize context = _context, library = _library;

-(id) initWithContext:(SPPhysicsContext*)aContext andLibrary:(SPPhysicsLibrary*)aLibrary{
    
    if(self = [super init]){
        _context = aContext;
        _library = aLibrary;
    }
    return self;
}

// produces a UI from an XML file.
-(void) loadObjectsFromXMLFile:(NSString*)filename{
    
	// Pull out the <objects> node from our level file
	SMXMLElement *objects = [Utils getXMLElement:OBJECTS_KEY fromFile:filename];
	
	// Look through <views> children of type <view>
	for (SMXMLElement *object in [objects childrenNamed:OBJECT_KEY]) {
        
        //Step 1: Identify the object to build.
        SPPhysicsPrefab *prefab = [_library getPrefabByName:[object attributeNamed:@"prefab"]];
        
        //Step 2: Extract the rest of the implementation details from the prefab
    
        //Step 2: Send the object to the factory for construction.
        [_context.factory createObjectFromPrefab:prefab andElement:object];
        
        //Step 3: Add the object to the current scene.
	}
}

-(void) dealloc {
    
    [_library release];
    [_context release];
    _context = nil;
    _library = nil;
    
    [super dealloc];
}
@end
