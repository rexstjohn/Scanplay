//
//  SPPhysicsFactory.h
//  Flywheels
//
//  Created by Rex St John on 6/18/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPPhysicsFactory : NSObject


-(SPGear*)createGear:(CGRect)rect andTeeth:(int)teeth;
-(SPPhysicsObject*)createCircle:(CGRect)rect;

@end
