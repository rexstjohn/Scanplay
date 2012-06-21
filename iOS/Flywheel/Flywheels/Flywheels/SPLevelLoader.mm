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
#import "SPPhysicsFactory.h"
#import "Utils.h"
#import "GameConfig.h"

// The purpose of this class is to provide a rapid method for loading levels.
@implementation SPLevelLoader

@synthesize context = _context, library = _library, factory = _factory;

-(id) initWithContext:(SPPhysicsContext*)aContext andLibrary:(SPPhysicsLibrary*)aLibrary{
    
    if(self = [super init]){
        _context = aContext;
        _library = aLibrary;
        _factory = _context.factory;
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
        
        //Step 2: Extract the dimensions of the target object.
        float height = [[object attributeNamed:HEIGHT] floatValue];
        float width= [[object attributeNamed:WIDTH] floatValue];
        float x= [[object attributeNamed:X] floatValue];
        float y= [[object attributeNamed:Y] floatValue];
        
        SPPhysicsObject *newObject; //our new physics object
        
        //TODO: add a list of everything we need to create here.
        //Step 2: Send the object to the factory for construction.
        if ([[prefab prefabType] isEqualToString:PRIMITIVE_OBJECT]) {
            
            //create either a circle or a basic block shape
            if([prefab.shape isEqual:@"circle"]){
                
                // Create a circle.
               newObject = [_factory createCircleWithRadius:width
                                 atPosition:CGPointMake(x,y)
                                 withSkin:prefab.material.textureName 
                                 isDynamic:YES];
            }
            else if([prefab.shape isEqual:@"block"]){
                // Create a box.
                newObject = [_factory createBoxWithRect:CGRectMake(x, y, width, height) withSkin:prefab.material.textureName isDynamic:YES];
            }
            else if([prefab.shape isEqual:@"polygon"]){
                // Create a polygon.
                //newObject = [_factory createPolygonWithPoints:<#(NSArray *)#> withSkin:prefab.material.textureName isDynamic:YES atPoint:<#(CGPoint)#>]
            }
        }
        else if([[prefab prefabType] isEqualToString:ROPE_OBJECT]){
            [[_context factory] createObjectFromPrefab:prefab andRect:CGRectMake(x, y, width, height)];
        }
            else if([[prefab prefabType] isEqualToString:GEAR_OBJECT]){
            [[_context factory] createObjectFromPrefab:prefab andRect:CGRectMake(x, y, width, height)];
        }
        
	}
}

-(void) dealloc {
    
    [_library release];
    [_context release];
    [_factory release];
    _context = nil;
    _library = nil;
    _factory = nil;
    
    [super dealloc];
}
@end
