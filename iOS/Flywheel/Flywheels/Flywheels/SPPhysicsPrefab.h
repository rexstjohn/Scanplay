//
//  APPhysicsPrefab.h
//  Flywheels
//
//  Created by Rexford St. John on 6/20/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMXMLDocument.h"
#import "SPPhysicsMaterial.h"
#import "SPPhysicsShape.h"

@interface SPPhysicsPrefab : NSObject

-(id)initWithId:(NSString*)aPrefId 
    andMaterial:(SPPhysicsMaterial*)aMaterial 
       andShape:(SPPhysicsShape*)aShape 
         ofType:(NSString*)aType;

@property(nonatomic,retain) SPPhysicsMaterial *material;
@property(nonatomic,retain) SPPhysicsShape *shape;
@property(nonatomic,retain) NSString *prefabId;
@property(nonatomic,retain) NSString *prefabType;

@end
