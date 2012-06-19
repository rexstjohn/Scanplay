//
//  SPPhysicsFactory.m
//  Flywheels
//
//  Created by Rex St John on 6/18/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "SPPhysicsFactory.h"

@implementation SPPhysicsFactory


-(SPGear*)createGear:(CGRect)rect andTeeth:(int)teeth
{
    SPGear *newGear = [[SPGear alloc] initWithRect:rect];
    return newGear;
}

-(SPPhysicsObject*)createCircle:(CGRect)rect
{
    
}

@end
