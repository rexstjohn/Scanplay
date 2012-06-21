//
//  GameConfig.h
//  Flywheels
//
//  Created by Rex St John on 6/18/12.
//  Copyright Scanplay Games 2012. All rights reserved.
//

//physics config
#define FRAME_RATE 1.0/60
#define GRAVITY    -10.0f
#define DO_SLEEP  true
#define PTM_RATIO  32.0f

// XML related fields and corresponding values.
#define DEFINITIONS_FILE_NAME  @"definitions"
#define HEIGHT                 @"height"
#define WIDTH                  @"width"
#define X                      @"x"
#define Y                      @"y"
#define PREFAB_ID              @"id"
#define PREFAB                 @"prefab"
#define RESTITUTION            @"restitution"
#define FRICTION               @"friction"
#define MASS                   @"mass"
#define MATERIAL_ID            @"id"
#define TEXTURE                @"texture"
#define MATERIALS              @"materials"
#define MATERIAL               @"material"
#define SHAPES                 @"shapes"
#define SHAPE                  @"shape"
#define PREFABS                @"prefabs"
#define PREFAB                 @"prefab"
#define TYPE                   @"type"
#define DEFAULT_CLASS_NAME     @"SPPhysicsObject"
#define SHAPE_ID               @"id"

//primitive object defs (possible types of a prefab)
#define PRIMITIVE_OBJECT @"primitive"
#define GEAR_OBJECT      @"gear"
#define ROPE_OBJECT      @"rope"


#ifndef __GAME_CONFIG_H
    #define __GAME_CONFIG_H

    //
    // Supported Autorotations:
    //		None,
    //		UIViewController,
    //		CCDirector
    //
    #define kGameAutorotationNone 0
    #define kGameAutorotationCCDirector 1
    #define kGameAutorotationUIViewController 2

    //
    // Define here the type of autorotation that you want for your game
    //

    // 3rd generation and newer devices: Rotate using UIViewController. Rotation should be supported on iPad apps.
    // TIP:
    // To improve the performance, you should set this value to "kGameAutorotationNone" or "kGameAutorotationCCDirector"
    #if defined(__ARM_NEON__) || TARGET_IPHONE_SIMULATOR
        #define GAME_AUTOROTATION kGameAutorotationUIViewController

    // ARMv6 (1st and 2nd generation devices): Don't rotate. It is very expensive
    #elif __arm__
        #define GAME_AUTOROTATION kGameAutorotationNone


    // Ignore this value on Mac
    #elif defined(__MAC_OS_X_VERSION_MAX_ALLOWED)

    #else
        #error(unknown architecture)
    #endif

#endif // __GAME_CONFIG_H

