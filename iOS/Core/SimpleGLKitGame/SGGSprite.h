//
//  SGGSprite.h
//  SimpleGLKitGame
//
//  Created by Ray Wenderlich on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "SGGNode.h"

@interface SGGSprite : SGGNode

- (id)initWithFile:(NSString *)fileName effect:(GLKBaseEffect *)effect;

@end
