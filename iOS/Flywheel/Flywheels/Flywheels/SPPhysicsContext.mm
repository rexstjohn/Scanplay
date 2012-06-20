//
//  PhysicsContext.m
//  Flywheels
//
//  Created by Rexford St. John on 6/19/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "SPPhysicsContext.h"
#import "SPPhysicsWorld.h"
#import "SPPhysicsFactory.h"
#import "SPPhysicsViewController.h"
#import "GameConfig.h"
#import "CCDirector.h"
#import "SPPhysicsGameLayer.h"
#import "SPLevelLoader.h"
#import "SPUILoader.h"

@implementation SPPhysicsContext

@synthesize world = _world, factory = _factory, viewController = _viewController, window = _window, layer =_layer, uiLoader = _uiLoader, levelLoader = _levelLoader;

-(id)initWithWindow:(UIWindow*)aWindow {
    
    if(self = [super init]) {
        _window = aWindow;
        
        //create our physics world
		CGSize screenSize = [CCDirector sharedDirector].winSize;
        _world = [[SPPhysicsWorld alloc] initWithSize:screenSize];
        
        //create our factory
        _factory = [[SPPhysicsFactory alloc] initWithPhysicsContext:self];
        
        //create the window and physics world
        
        // Init the View Controller
        _viewController = [[SPPhysicsViewController alloc] initWithNibName:nil bundle:nil];
        _viewController.wantsFullScreenLayout = YES;
        
        // Create the EAGLView 
        //  1. Create a RGB565 format. Alternative: RGBA8
        //	2. depth format of 0 bit. Use 16 or 24 bit for 3d effects, like CCPageTurnTransition
        EAGLView *glView = [EAGLView viewWithFrame:[_window bounds]
                                       pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
                                       depthFormat:0						// GL_DEPTH_COMPONENT16_OES
                            ];
        
        // attach the openglView to the director
        CCDirector *director = [CCDirector sharedDirector];
        [director setOpenGLView:glView];
        
        //	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
        //	if( ! [director enableRetinaDisplay:YES] )
        //		CCLOG(@"Retina Display Not supported");
        
        // VERY IMPORTANT:
        // If the rotation is going to be controlled by a UIViewController
        // then the device orientation should be "Portrait".
        //
        // IMPORTANT:
        // By default, this template only supports Landscape orientations.
        // Edit the RootViewController.m file to edit the supported orientations.
        if(GAME_AUTOROTATION == kGameAutorotationUIViewController)
            [director setDeviceOrientation:kCCDeviceOrientationPortrait];
        else
            [director setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
        
        [director setAnimationInterval:FRAME_RATE];
        [director setDisplayFPS:YES];
        
        // make the OpenGLView a child of the view controller
        [_viewController setView:glView];
        
        // make the View Controller a child of the main window
        [_window addSubview: _viewController.view];
        [_window makeKeyAndVisible];
        
        // Default texture format for PNG/BMP/TIFF/JPEG/GIF images
        // It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
        // You can change anytime.
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
        
        // Run the intro Scene
        CCScene *scene = [CCScene node]; // 'scene' is an autorelease object.
        _layer = [[SPPhysicsGameLayer alloc] initWithWorld:_world];
        [scene addChild: _layer];// add layer as a child to scene
        
        //start the scene
        [[CCDirector sharedDirector] runWithScene: scene];
        
        //create utility loader helpers
        _uiLoader = [[SPUILoader alloc] initWithContext:self];
        _levelLoader = [[SPLevelLoader alloc] initWithContext:self];
    }
    
    return self;
}

// CCDirector important methods
- (void)pause{
	[[CCDirector sharedDirector] pause];
}

- (void)resume{
	[[CCDirector sharedDirector] resume];
}

- (void)purgeCachedData{
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void)stopAnimation{
	[[CCDirector sharedDirector] stopAnimation];
}

-(void)startAnimation{
	[[CCDirector sharedDirector] startAnimation];
}

- (void)setNextDeltaTimeZero{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

//destructor
- (void) dealloc {
    
    //destroy the director
	CCDirector *director = [CCDirector sharedDirector];
	[[director openGLView] removeFromSuperview];
    [director end];	
    
    //release
    [_window release];
    [_viewController release];
    [_world release];
    [_factory release];
    [_uiLoader release];
    [_levelLoader release];
    
    //nil
    _window = nil;
    _viewController = nil;
    _world = nil;
    _factory = nil;
    _uiLoader = nil;
    _levelLoader = nil;
    [super dealloc];
}

@end
