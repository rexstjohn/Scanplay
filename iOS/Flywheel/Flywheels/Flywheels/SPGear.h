//
//  Gear.h
//  Flywheels
//
//  Created by Rex St John on 6/18/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "CCSprite.h"

@interface SPGear : CCSprite

//Array of points from which to build the gear.
-(id)initWithPoints:(NSMutableArray*) points;

// Builds a gear in a certain rectangular area
-(id) initWithRect:(CGRect) rect;

@end
