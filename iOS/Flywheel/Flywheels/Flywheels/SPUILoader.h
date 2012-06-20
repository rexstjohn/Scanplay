//
//  UILoader.h
//  Flywheels
//
//  Created by Rexford St. John on 6/20/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SPPhysicsContext;

@interface SPUILoader : NSObject {
    
}

// init with a context
-(id) initWithContext:(SPPhysicsContext*)aContext;

// produces a UI from an XML file.
-(void) loadUIFromXMLFile:(NSString*)filename;

@property(nonatomic,retain) SPPhysicsContext *context;

@end
