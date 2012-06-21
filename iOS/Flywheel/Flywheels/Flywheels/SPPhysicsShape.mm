//
//  SPPhysicsShape.m
//  Flywheels
//
//  Created by Rexford St. John on 6/20/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "SPPhysicsShape.h"
#import "SMXMLDocument.h"
#import "GameConfig.h"

@implementation SPPhysicsShape

@synthesize shapeId = _shapeId;

-(id)initWithXMLElement:(SMXMLElement*)anElement{
    
    if(self = [super init]){
        
        _shapeId = [anElement attributeNamed:SHAPE_ID];
    }
    
    return self;
}

-(void)dealloc{
    
    [_shapeId release];
    _shapeId=nil;
    
    [super dealloc];
}

@end