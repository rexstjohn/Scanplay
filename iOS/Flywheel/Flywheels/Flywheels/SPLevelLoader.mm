//
//  LevelLoader.m
//  Flywheels
//
//  Created by Rexford St. John on 6/20/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "SPLevelLoader.h"
#import "SMXMLDocument.h"
#import "Utils.h"

// The purpose of this class is to provide a rapid method for loading levels.
@implementation SPLevelLoader

@synthesize context = _context;

-(id) initWithContext:(SPPhysicsContext*)aContext{
    
    if(self = [super init]){
        _context = aContext;
    }
    
    return self;
}

// produces a UI from an XML file.
-(void) loadUIFromXMLFile:(NSString*)filename{
    
	// Pull out the <views> node
	SMXMLElement *views = [Utils getXMLElement:@"objects" fromFile:@"objects"];
	
	// Look through <views> children of type <view>
	for (SMXMLElement *view in [views childrenNamed:@"object"]) {
        
        //load level stuff here
        //		// demonstrate common cases of extracting XML data
        //		NSString *isbn = [book attributeNamed:@"isbn"]; // XML attribute
        //		NSString *title = [book valueWithPath:@"title"]; // child node value
        //		float price = [[book valueWithPath:@"price"] floatValue]; // child node value (converted)
        //		
        //		// show off some KVC magic
        //		NSArray *authors = [[book childNamed:@"authors"].children valueForKey:@"value"];
        //		
        //		NSLog(@"Found a book!\n ISBN: %@ \n Title: %@ \n Price: %f \n Authors: %@", isbn, title, price, authors);
	}
}

-(void) dealloc {
    
    [_context release];
    _context = nil;
    
    [super dealloc];
}
@end
