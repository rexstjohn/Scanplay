//
//  SPPhysicsPrefabManagedObject.h
//  Flywheels
//
//  Created by Rexford St. John on 6/20/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SPPhysicsMaterialManagedObject, SPPhysicsShapeManagedObject;

@interface SPPhysicsPrefabManagedObject : NSManagedObject

@property (nonatomic, retain) NSString * prefab_name;
@property (nonatomic, retain) SPPhysicsMaterialManagedObject *material;
@property (nonatomic, retain) SPPhysicsShapeManagedObject *shape;

@end
