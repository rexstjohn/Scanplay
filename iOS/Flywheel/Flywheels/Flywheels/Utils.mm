//
//  Utils.m
//  Flywheels
//
//  Created by Rex St John on 6/18/12.
//  Copyright (c) 2012 Scanplay Games. All rights reserved.
//

#import "Utils.h"
#import "GameConfig.h"
#import "SMXMLDocument.h"

@implementation Utils

+(CGPoint)toMeters:(CGPoint)point {
    
    return CGPointMake(point.x / kPTM_RATIO, point.y / kPTM_RATIO);
}

+(SMXMLElement*) getXMLElement:(NSString*)elementName fromFile:(NSString*)fileName{
    
	// pull the data from an xml file
	NSString *someXML = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
	NSData *data = [NSData dataWithContentsOfFile:someXML];
	
	// create a new SMXMLDocument with the contents of the xml
    NSError *error;
	SMXMLDocument *document = [SMXMLDocument documentWithData:data error:&error];
    
    // check for errors
    if (error) {
        NSLog(@"Error while parsing the document: %@", error);
    }
	
	// Pull out the <elements> nodes
	SMXMLElement *elements = [document.root childNamed:elementName];
    return elements;
}


@end
