//
//  SPPhysicsLibrary.h
//  Flywheels
//
//  Created by Rexford St. John on 6/20/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SPPhysicsObject;

//file names
#define MATERIAL_FILE_NAME @"materials"
#define SHAPE_FILE_NAME    @"shapes"
#define PREFABS_FILE_NAME  @"prefabs"

//keys for the xml file types
#define MATERIALS  @"materials"
#define MATERIAL   @"material"
#define SHAPES     @"shapes"
#define SHAPE      @"shape"
#define PREFABS    @"prefabs"
#define PREFAB     @"prefab"

// This class is used to import a list of physics prefabs, materials and shapes.
// The physics builder class can then use this library to dynamically construct arbitrary physics objects
// from level files.
@interface SPPhysicsLibrary : NSObject

// initialize the library with materials and physics objects. 
-(id) initWithPrefabs:(NSString*)prefabFile andMaterials:(NSString*)materialFile andShapes:(NSString*)shapeFile;

//library of physics prefabs available to be constructed.
@property(nonatomic,retain) NSMutableDictionary *prefabs;

//library of physics shapes available to be constructed.
@property(nonatomic,retain) NSMutableDictionary *shapes;

//Library of materials available to apply to objects.
@property(nonatomic,retain) NSMutableDictionary *materials;

@end
