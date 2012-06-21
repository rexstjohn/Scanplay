//
//  APPhysicsPrefab.m
//  Flywheels
//
//  Created by Rexford St. John on 6/20/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "SPPhysicsPrefab.h"
#import "GameConfig.h"

@implementation SPPhysicsPrefab

@synthesize material = _material, shape = _shape, prefabId = _prefabId, prefabType=_prefabType;

-(id)initWithId:(NSString*)aPrefId 
    andMaterial:(SPPhysicsMaterial*)aMaterial 
       andShape:(SPPhysicsShape*)aShape 
         ofType:(NSString*)aType{
    
    if(self = [super init]){
        
        _prefabId = aPrefId;
        _material = aMaterial;
        _shape = aShape;
        _prefabType = aType;
    }
    
    return self;
}

-(void)dealloc{
    
    [_prefabType release];
    [_material release];
    [_shape release];
    [_prefabId release];
    
    _prefabType = nil;
    _material = nil;
    _shape = nil;
    _prefabId = nil;
    
    [super dealloc];
}


@end
