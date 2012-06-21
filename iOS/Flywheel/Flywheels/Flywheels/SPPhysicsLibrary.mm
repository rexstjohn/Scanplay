//
//  SPPhysicsLibrary.m
//  Flywheels
//
//  Created by Rexford St. John on 6/20/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "SPPhysicsLibrary.h"
#import "Utils.h"
#import "SMXMLDocument.h"
#import "SPPhysicsMaterial.h"
#import "SPPhysicsShape.h"
#import "SPPhysicsPrefab.h"

@interface  SPPhysicsLibrary ()

// internal methods used to load all the physics object definitions for later assembly.
-(void) loadMaterialsLibrary;
-(void) loadShapesLibrary;
-(void) loadPrefabsLibrary;

@end

@implementation SPPhysicsLibrary

@synthesize prefabs = _prefabs, materials = _materials, shapes = _shapes;

// The goal here is to have ready made objects which can easily be insanciated via XML level files in the future.
-(id) initWithPrefabs:(NSString*)prefabFile andMaterials:(NSString*)materialFile andShapes:(NSString*)shapeFile
{
    if(self = [super init])
    {
        _prefabs   = [[NSMutableDictionary alloc] init];
        _materials = [[NSMutableDictionary alloc] init];
        _shapes    = [[NSMutableDictionary alloc] init];
        
        //step 1: save all the material definitions into the materials collection by key.
        [self loadMaterialsLibrary];
        
        //step 2: save all the shape definitions into the shapes collection by key.
        [self loadShapesLibrary];
        
        //step 3: initialize all the prefabs and store them in the prefabs collection by key.
        [self loadPrefabsLibrary];
    }
    
    return self;
}

-(void) loadMaterialsLibrary{

	// Pull out the <material> node
	SMXMLElement *materialsElements = [Utils getXMLElement:MATERIALS fromFile:MATERIAL_FILE_NAME];
	
	// Look through <material> children of type <material>
	for (SMXMLElement *mat in [materialsElements childrenNamed:MATERIAL]) {
                
        // dump all the material object definitions into the library
        SPPhysicsMaterial *newMaterial = [[SPPhysicsMaterial alloc] initWithXMLElement:mat];
        [_materials setValue:newMaterial forKey:newMaterial.materialId];
	}
}

-(void) loadShapesLibrary{
    
	// Pull out the <shape> node
	SMXMLElement *shapesElements = [Utils getXMLElement:SHAPES fromFile:SHAPE_FILE_NAME];
	
	// Look through <shape> children of type <shape>
	for (SMXMLElement *shape in [shapesElements childrenNamed:SHAPE]) {
        
        // dump all the shape object definitions into the library
        SPPhysicsShape *newShape = [[SPPhysicsShape alloc] initWithXMLElement:shape];
        [_shapes setValue:newShape forKey:newShape.shapeId];
	}
}

-(void) loadPrefabsLibrary{
    
	// Pull out the <prefab> node
	SMXMLElement *prefabsElement = [Utils getXMLElement:PREFABS fromFile:PREFABS_FILE_NAME];
	
	// Look through <prefab> children of type <prefab>
	for (SMXMLElement *pref in [prefabsElement childrenNamed:PREFAB]) {
        
        NSString *materialId = [pref attributeNamed:MATERIAL];
        NSString *shapeId = [pref attributeNamed:SHAPE];
        NSString *prefabId = [pref attributeNamed:PREFAB_ID];
        
        // dump all the prefab object definitions into the library
        SPPhysicsPrefab *newPrefab = [[SPPhysicsPrefab alloc] initWithId:prefabId andMaterial:[_materials valueForKey:materialId] andShape:[_shapes valueForKey:shapeId]];
        [_prefabs setValue:newPrefab forKey:prefabId];
	}
}

@end
