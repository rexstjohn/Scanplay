//
//  Utils.m
//  Flywheels
//
//  Created by Rex St John on 6/18/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "Utils.h"

@implementation Utils

#define PTM_RATIO 32

+(CGPoint)toMeters:(CGPoint)point
{
    return CGPointMake(point.x / PTM_RATIO, point.y / PTM_RATIO);
}

@end
