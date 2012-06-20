//
//  SPPhysicsShape.h
//  Flywheels
//
//  Created by Rexford St. John on 6/20/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "SMXMLDocument.h"

#define SHAPE_ID     @"id"

@interface SPPhysicsShape : NSObject

-(id)initWithXMLElement:(SMXMLElement*)anElement;

@property(nonatomic,retain) NSString *shapeId;

@end
