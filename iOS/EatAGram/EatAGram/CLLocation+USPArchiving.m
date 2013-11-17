//
//  CLLocation+USPArchiving.m
//  EatAGram
//
//  Created by JASON CROSS on 4/10/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "CLLocation+USPArchiving.h"

@implementation CLLocation (USPArchiving) 

#pragma mark - NSCoding

// we need to Suppress warning “Category is implementing a method which will also be implemented by its primary class”
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeFloat:self.coordinate.latitude forKey:@"latitude"];
    [aCoder encodeFloat:self.coordinate.longitude forKey:@"longitude"];
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = (CLLocationDegrees)[aDecoder decodeFloatForKey:@"longitude"];
    coordinate.longitude = (CLLocationDegrees)[aDecoder decodeFloatForKey:@"latitude"];
    
    self = [self initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    return self;
}
#pragma clang diagnostic pop
@end
