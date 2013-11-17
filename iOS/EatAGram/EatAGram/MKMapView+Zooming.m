//
//  MKMapView+Zooming.m
//  EatAGram
//
//  Created by Rex St John on 1/28/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import "MKMapView+Zooming.h"

#define MINIMUM_ZOOM_ARC   0.014f //approximately 1 miles (1 degree of arc ~= 69 miles)
#define MAX_DEGREES_ARC    360.0f

@implementation MKMapView (Zooming)

- (MKMapRect) mapRectToFitAnnotations:(NSArray*)annotations; {
    MKMapRect value = [self mapRectToFitAnnotations:annotations
                                       withLocation:nil];
    return value;
}

- (MKMapRect)mapRectToFitAnnotationsWithLocation:(CLLocation*)location; {
    NSArray *annotations = self.annotations;
    MKMapRect value = [self mapRectToFitAnnotations:annotations
                                       withLocation:location];
    return value;
}

- (MKMapRect)mapRectToFitAnnotations:(NSArray*)annotations withLocation:(CLLocation*)location; {
    // code borrowed from: http://brianreiter.org/2012/03/02/size-an-mkmapview-to-fit-its-annotations-in-ios-without-futzing-with-coordinate-systems/

    int count = [annotations count];
    if ( count == 0) {
        MKMapPoint point = MKMapPointForCoordinate(self.centerCoordinate);
        MKMapSize size = MKMapSizeMake(800, 800);
        MKMapRect rect = {point, size};
        
        //bail if no annotations
        return rect;
    }
    
    if (nil != location) {
        ++count;
    }
    
    //convert NSArray of id <MKAnnotation> into an MKCoordinateRegion that can be used to set the map size
    //can't use NSArray with MKMapPoint because MKMapPoint is not an id
    MKMapPoint points[count]; //C array of MKMapPoint struct
    for( int i=0; i<count - 1; i++ ) //load points C array by converting coordinates to points
    {
        CLLocationCoordinate2D coordinate = [(id <MKAnnotation>)[annotations objectAtIndex:i] coordinate];
        points[i] = MKMapPointForCoordinate(coordinate);
    }
    // is the last point from an annotation or from the location passed in?
    int index = count - 1;
    CLLocationCoordinate2D coordinate;
    if (nil == location) {
        coordinate = [(id <MKAnnotation>)[annotations objectAtIndex:index] coordinate];
    }
    else {
        coordinate = location.coordinate;
    }
    points[index] = MKMapPointForCoordinate(coordinate);
    
    //create MKMapRect from array of MKMapPoint
    MKMapRect mapRect = [[MKPolygon polygonWithPoints:points count:count] boundingMapRect];
    //convert MKCoordinateRegion from MKMapRect
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(mapRect);
    
    //add padding so pins aren't scrunched on the edges
    region.span.latitudeDelta  *= ANNOTATION_REGION_PAD_FACTOR;
    region.span.longitudeDelta *= ANNOTATION_REGION_PAD_FACTOR;
    //but padding can't be bigger than the world
    if( region.span.latitudeDelta > MAX_DEGREES_ARC ) { region.span.latitudeDelta  = MAX_DEGREES_ARC; }
    if( region.span.longitudeDelta > MAX_DEGREES_ARC ){ region.span.longitudeDelta = MAX_DEGREES_ARC; }
    
    //and don't zoom in stupid-close on small samples
    if( region.span.latitudeDelta  < MINIMUM_ZOOM_ARC ) { region.span.latitudeDelta  = MINIMUM_ZOOM_ARC; }
    if( region.span.longitudeDelta < MINIMUM_ZOOM_ARC ) { region.span.longitudeDelta = MINIMUM_ZOOM_ARC; }
    //and if there is a sample of 1 we want the max zoom-in instead of max zoom-out
    if( count == 1 )
    {
        region.span.latitudeDelta = MINIMUM_ZOOM_ARC;
        region.span.longitudeDelta = MINIMUM_ZOOM_ARC;
    }
    
    MKMapRect value = mapRectForCoordinateRegion(region);
    return value;
}

-(void)zoomToFitAnnotationsAnimated:(BOOL)animated{
    
    MKMapRect rect = [self mapRectToFitAnnotationsWithLocation:nil];
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(rect);
    
    if([self regionIsValid:region] == YES){
        
        // if we don't set the region on the main thread,
        // the UI will often not update, especially upon the map view's viewWillAppear
        dispatch_async(dispatch_get_main_queue(),^{
            [self setRegion:region animated:animated];
        });
        
    } else {
        NSLog(@"Warning: Invalid Region Detected");
    }
}

- (void)zoomtofitAnnotationsCenteredOnLocation:(CLLocation*)location animated:(BOOL)animated; {
    
    MKMapRect rect = [self mapRectToFitAnnotationsWithLocation:location];
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(rect);
    
    if([self regionIsValid:region] == YES){
        
        // if we don't set the region on the main thread,
        // the UI will often not update, especially upon the map view's viewWillAppear
        dispatch_async(dispatch_get_main_queue(),^{
            [self setRegion:region animated:animated];
        });
        
    } else {
        NSLog(@"Warning: Invalid Region Detected");
    }

}

-(BOOL)regionIsValid:(MKCoordinateRegion)region{
    
    if(CLLocationCoordinate2DIsValid(region.center) == NO){
        return NO;
    } else if (region.span.latitudeDelta <= 0.0f || region.span.longitudeDelta <= 0.0f) {
        return NO;
    } else if (region.center.latitude > 90.0f || region.center.latitude < -90.0f ||
        region.center.longitude > 360.0f || region.center.longitude < -180.0f
        ) {
        return NO;
    }
    return YES;
}

-(void)zoomToLocation:(CLLocation*)location withMarginInMiles:(CGFloat)miles animated:(BOOL)animated{
    
    double scalingFactor = ABS( (cos(2 * M_PI * self.userLocation.coordinate.latitude / 360.0) ));
    
    MKCoordinateSpan span;
    span.latitudeDelta = miles/69.0;
    span.longitudeDelta = miles/(scalingFactor * 69.0);
    
    MKCoordinateRegion region;
    region.span = span;
    region.center = location.coordinate;
    
    [self setRegion:region animated:animated];
}

-(void)zoomToUserWithMarginInMiles:(CGFloat)miles{
    
    double scalingFactor = ABS( (cos(2 * M_PI * self.userLocation.coordinate.latitude / 360.0) ));
    
    MKCoordinateSpan span;
    span.latitudeDelta = miles/69.0;
    span.longitudeDelta = miles/(scalingFactor * 69.0);
    
    MKCoordinateRegion region;
    region.span = span;
    region.center = self.userLocation.coordinate;
    
    [self setRegion:region animated:YES];
}

- (MKZoomScale)zoomScale
{
    MKZoomScale currentZoomScale = self.bounds.size.width / self.visibleMapRect.size.width;
    return currentZoomScale;
}

+ (MKMapRect)mapRectForRegion:(MKCoordinateRegion) coordinateRegion; {
    CLLocationCoordinate2D topLeftCoordinate =
    CLLocationCoordinate2DMake(coordinateRegion.center.latitude
                               + (coordinateRegion.span.latitudeDelta/2.0),
                               coordinateRegion.center.longitude
                               - (coordinateRegion.span.longitudeDelta/2.0));
    
    MKMapPoint topLeftMapPoint = MKMapPointForCoordinate(topLeftCoordinate);
    
    CLLocationCoordinate2D bottomRightCoordinate =
    CLLocationCoordinate2DMake(coordinateRegion.center.latitude
                               - (coordinateRegion.span.latitudeDelta/2.0),
                               coordinateRegion.center.longitude
                               + (coordinateRegion.span.longitudeDelta/2.0));
    
    MKMapPoint bottomRightMapPoint = MKMapPointForCoordinate(bottomRightCoordinate);
    
    MKMapRect mapRect = MKMapRectMake(topLeftMapPoint.x,
                                      topLeftMapPoint.y,
                                      fabs(bottomRightMapPoint.x-topLeftMapPoint.x),
                                      fabs(bottomRightMapPoint.y-topLeftMapPoint.y));
    return mapRect;
}

@end
