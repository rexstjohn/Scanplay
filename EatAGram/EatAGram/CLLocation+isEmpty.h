//
//  CLLocation+isEmpty.h
//  EatAGram
//
//  Created by JASON CROSS on 3/21/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (isEmpty)
+ (BOOL) isEmpty:(CLLocation*)thing;
@end
