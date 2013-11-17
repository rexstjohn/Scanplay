//
//  CLLocation+CompareCoordinatesToSignificantDecimals.h
//  EatAGram
//
//  Created by Jason Cross on 5/23/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

static inline BOOL coordinatesAreEqualToDecimals(CLLocationCoordinate2D firstCoordinate, CLLocationCoordinate2D secondCoordinate, int decimalPlaces) {
    int decimalsToShift = (decimalPlaces > 0) ? decimalPlaces : 1;
    int m = 10 * decimalsToShift;
    BOOL latitudesAreEqual = (int)(m * firstCoordinate.latitude) == (int)(m * secondCoordinate.latitude);
    BOOL longitudesAreEqual = (int)(m * firstCoordinate.longitude) == (int)(m * secondCoordinate.longitude);
    BOOL value = latitudesAreEqual && longitudesAreEqual;
    return value;
}

@interface CLLocation (CompareCoordinatesToSignificantDecimals)


@end
