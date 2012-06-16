//
//  SGGGameOverScene.m
//  SimpleGLKitGame
//
//  Created by Ray Wenderlich on 2/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SGGGameOverScene.h"
#import "SGGSprite.h"
#import "SGGViewController.h"
#import "SGGActionScene.h"
#import "SGGAppDelegate.h"

@interface SGGGameOverScene ()
@property (assign) float timeSinceInit;
@property (strong) GLKBaseEffect * effect;
@end

@implementation SGGGameOverScene
@synthesize timeSinceInit = _timeSinceInit;
@synthesize effect = _effect;

- (id)initWithEffect:(GLKBaseEffect *)effect win:(BOOL)win {
    if ((self = [super init])) {

        self.effect = effect;
        if (win) {
            SGGSprite * winSprite = [[SGGSprite alloc] initWithFile:@"YouWin.png" effect:effect];
            winSprite.position = GLKVector2Make(240, 160);
            [self addChild:winSprite];
        } else {
            SGGSprite * loseSprite = [[SGGSprite alloc] initWithFile:@"YouLose.png" effect:effect];
            loseSprite.position = GLKVector2Make(240, 160);
            [self addChild:loseSprite];
        }
        
    }
    return self;
}

- (void)update:(float)dt {
    
    self.timeSinceInit += dt;
    if (self.timeSinceInit > 3.0) {
        SGGActionScene * scene = [[SGGActionScene alloc] initWithEffect:self.effect];
        SGGAppDelegate * delegate = [[UIApplication sharedApplication] delegate];
        UIWindow * mainWindow = [delegate window];
        SGGViewController * viewController = (SGGViewController *) mainWindow.rootViewController;
        viewController.scene = scene;
    }
    
}

@end
