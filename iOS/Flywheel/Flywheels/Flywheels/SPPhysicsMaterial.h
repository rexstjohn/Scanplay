//
//  SPPhysicsMaterial.h
//  Flywheels
//
//  Created by Rexford St. John on 6/20/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMXMLDocument.h"

#define RESTITUTION  @"restitution"
#define FRICTION     @"friction"
#define MASS         @"mass"
#define MATERIAL_ID  @"id"
#define TEXTURE      @"texture"

@interface SPPhysicsMaterial : NSObject

-(id)initWithXMLElement:(SMXMLElement*)anElement;

@property(nonatomic,retain) NSNumber *restitution;
@property(nonatomic,retain) NSNumber *mass;
@property(nonatomic,retain) NSNumber *friction;
@property(nonatomic,retain) NSString *materialId;
@property(nonatomic,retain) NSString *textureName;

@end
