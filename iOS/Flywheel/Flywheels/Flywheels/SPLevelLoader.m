//
//  LevelLoader.m
//  Flywheels
//
//  Created by Rexford St. John on 6/20/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "SPLevelLoader.h"
#import "SMXMLDocument.h"

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
    
	// find "sandbox.xml" in our bundle resources
	NSString *sampleXML = [[NSBundle mainBundle] pathForResource:filename ofType:@"xml"];
	NSData *data = [NSData dataWithContentsOfFile:sampleXML];
	
	// create a new SMXMLDocument with the contents of sample.xml
    NSError *error;
	SMXMLDocument *document = [SMXMLDocument documentWithData:data error:&error];
    
    // check for errors
    if (error) {
        NSLog(@"Error while parsing the document: %@", error);
        return;
    }
    
	// demonstrate -description of document/element classes
	NSLog(@"Document:\n %@", document);
	
	// Pull out the <objects> node
	SMXMLElement *levelObjects = [document.root childNamed:@"objects"];
	
	// Look through <books> children of type <book>
	for (SMXMLElement *levelObject in [levelObjects childrenNamed:@"object"]) {
		
        //instanciate level objects in the context.
        
	}
}

-(void) dealloc {
    
    [_context release];
    _context = nil;
    
    [super dealloc];
}
@end
