//
//  SGGNode.h
//  SimpleGLKitGame
//
//  Created by Ray Wenderlich on 2/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface SGGNode : NSObject

@property (assign) GLKVector2 position;
@property (assign) CGSize contentSize;
@property (assign) GLKVector2 moveVelocity;
@property (retain) NSMutableArray * children;
@property (assign) float rotation;
@property (assign) float scale;
@property (assign) float rotationVelocity;
@property (assign) float scaleVelocity;

- (void)renderWithModelViewMatrix:(GLKMatrix4)modelViewMatrix; 
- (void)update:(float)dt;
- (GLKMatrix4) modelMatrix:(BOOL)renderingSelf;
- (CGRect)boundingBox;
- (void)addChild:(SGGNode *)child;
//**
- (void)handleTap:(CGPoint)touchLocation;
//**

@end
