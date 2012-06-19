//
//  Utils.h
//  Flywheels
//
//  Created by Rex St John on 6/18/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

//Convert a physics point into a world point.
+(CGPoint)toMeters:(CGPoint)point;

@end
