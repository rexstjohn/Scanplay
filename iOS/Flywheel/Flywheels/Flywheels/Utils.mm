//
//  Utils.m
//  Flywheels
//
//  Created by Rex St John on 6/18/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "Utils.h"
#import "GameConfig.h"

@implementation Utils

+(CGPoint)toMeters:(CGPoint)point {
    
    return CGPointMake(point.x / kPTM_RATIO, point.y / kPTM_RATIO);
}

@end
