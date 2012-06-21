//
//  APPhysicsPrefab.m
//  Flywheels
//
//  Created by Rexford St. John on 6/20/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "SPPhysicsPrefab.h"

@implementation SPPhysicsPrefab

@synthesize material = _material, shape = _shape, prefabId = _prefabId, className=_className;

-(id)initWithId:(NSString*)aPrefId andMaterial:(SPPhysicsMaterial*)aMaterial andShape:(SPPhysicsShape*)aShape ofClass:(NSString*)aClass{
    
    if(self = [super init]){
        
        _prefabId = aPrefId;
        _material = aMaterial;
        _shape = aShape;
        _className = aClass;
    }
    
    return self;
}

-(void)dealloc{
    
    [_prefabId release];
    [_material release];
    [_shape release];
    [_className release];
    
    _prefabId = nil;
    _material = nil;
    _shape = nil;
    _className = nil;
    
    [super dealloc];
}


@end
