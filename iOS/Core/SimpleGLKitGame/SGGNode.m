//
//  SGGNode.m
//  SimpleGLKitGame
//
//  Created by Ray Wenderlich on 2/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SGGNode.h"

@implementation SGGNode
@synthesize position = _position;
@synthesize contentSize = _contentSize;
@synthesize moveVelocity = _moveVelocity;
@synthesize children = _children;
@synthesize rotation = _rotation;
@synthesize scale = _scale;
@synthesize rotationVelocity = _rotationVelocity;
@synthesize scaleVelocity = _scaleVelocity;

- (id)init {
    if ((self = [super init])) {
        self.children = [NSMutableArray array];
        self.scale = 1;
    }
    return self;
}

- (void)renderWithModelViewMatrix:(GLKMatrix4)modelViewMatrix {
    GLKMatrix4 childModelViewMatrix = GLKMatrix4Multiply(modelViewMatrix, [self modelMatrix:NO]);
    for (SGGNode * node in self.children) {
        [node renderWithModelViewMatrix:childModelViewMatrix];
    }
}

- (void)update:(float)dt {
    
    for (SGGNode * node in self.children) {
        [node update:dt];
    }
    
    GLKVector2 curMove = GLKVector2MultiplyScalar(self.moveVelocity, dt);
    self.position = GLKVector2Add(self.position, curMove);
    
    float curRotate = self.rotationVelocity * dt;
    self.rotation = self.rotation + curRotate;

    float curScale = self.scaleVelocity * dt;
    self.scale = self.scale + curScale;
    
}

- (GLKMatrix4) modelMatrix:(BOOL)renderingSelf {
    
    GLKMatrix4 modelMatrix = GLKMatrix4Identity;    
    modelMatrix = GLKMatrix4Translate(modelMatrix, self.position.x, self.position.y, 0);
    
    float radians = GLKMathDegreesToRadians(self.rotation);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, radians, 0, 0, 1);

    modelMatrix = GLKMatrix4Scale(modelMatrix, self.scale, self.scale, 0);
    
    if (renderingSelf) {
        modelMatrix = GLKMatrix4Translate(modelMatrix, -self.contentSize.width/2, -self.contentSize.height/2, 0);
    }
    return modelMatrix;
    
}


- (CGRect)boundingBox {    
    CGRect rect = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
    GLKMatrix4 modelMatrix = [self modelMatrix:YES];
    CGAffineTransform transform = CGAffineTransformMake(modelMatrix.m00, modelMatrix.m01, modelMatrix.m10, modelMatrix.m11, modelMatrix.m30, modelMatrix.m31);    
    return CGRectApplyAffineTransform(rect, transform);
}

- (void)addChild:(SGGNode *)child {
    [self.children addObject:child];
}

//**
- (void)handleTap:(CGPoint)touchLocation {
    
}
//**

@end
