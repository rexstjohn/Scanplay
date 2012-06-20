//
//  SPPhysicsMaterialManagedObject.h
//  Flywheels
//
//  Created by Rexford St. John on 6/20/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SPPhysicsMaterialManagedObject : NSManagedObject

@property (nonatomic, retain) NSString * material_name;
@property (nonatomic, retain) NSNumber * friction;
@property (nonatomic, retain) NSNumber * restitution;
@property (nonatomic, retain) NSString * texture_file_name;
@property (nonatomic, retain) NSNumber * mass;

@end
