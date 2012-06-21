//
//  SPPhysicsMaterial.m
//  Flywheels
//
//  Created by Rexford St. John on 6/20/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "SPPhysicsMaterial.h"
#import "SMXMLDocument.h"
#import "GameConfig.h"

@implementation SPPhysicsMaterial

@synthesize restitution = _restitution, mass = _mass, friction = _friction, materialId = _materialId, textureName=_textureName;

-(id)initWithXMLElement:(SMXMLElement*)anElement{
    
    if(self = [super init]){
        
        _restitution = [NSNumber numberWithFloat:[[anElement attributeNamed:RESTITUTION] floatValue]];
        _mass        = [NSNumber numberWithFloat:[[anElement attributeNamed:MASS] floatValue]];
        _friction    = [NSNumber numberWithFloat:[[anElement attributeNamed:FRICTION] floatValue]];
        _materialId  = [anElement attributeNamed:MATERIAL_ID];
        _textureName = [anElement attributeNamed:TEXTURE];
    }
    
    return self;
}

-(void)dealloc{
    
    [_restitution release];
    [_mass release];       
    [_friction release];   
    [_materialId release]; 
    [_textureName release];
    
    _restitution=nil;
    _mass       =nil;  
    _friction   =nil;
    _materialId =nil;
    _textureName=nil;
    
    [super dealloc];
}
@end
