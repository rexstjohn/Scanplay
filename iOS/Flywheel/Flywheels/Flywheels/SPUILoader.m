//
//  UILoader.m
//  Flywheels
//
//  Created by Rexford St. John on 6/20/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "SPUILoader.h"
#import "SMXMLDocument.h"

// The purpose of this class is to provide an easy way of rapidly constructing a UI
// for the game from a single XML file.
@implementation SPUILoader

@synthesize context = _context;

-(id) initWithContext:(SPPhysicsContext*)aContext{
    
    if(self = [super init]){
        
        _context = aContext;
        
    }
    
    return self;
}

// produces a UI from an XML file.
-(void) loadUIFromXMLFile:(NSString*)filename{
    
	// find "level.xml" in our bundle resources
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
	
	// Pull out the <books> node
	SMXMLElement *books = [document.root childNamed:@"books"];
	
	// Look through <books> children of type <book>
	for (SMXMLElement *book in [books childrenNamed:@"book"]) {
        
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
