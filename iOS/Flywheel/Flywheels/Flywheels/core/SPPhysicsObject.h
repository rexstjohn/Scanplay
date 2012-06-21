//
//  SPPhysicsObject.h
//  Flywheels
//
//  Created by Rex St John on 6/18/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "b2Body.h"
@class CCSprite;

@interface SPPhysicsObject : NSObject{
    b2Body *_body;
}

-(id)initWithBody:(b2Body*) body andSprite:(CCSprite*) sprite;

@property(nonatomic, retain) CCSprite *sprite;

@end
