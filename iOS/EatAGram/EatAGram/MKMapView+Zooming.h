//
//  MKMapView+Zooming.h
//  EatAGram
//
//  Created by Rex St John on 1/28/13.
//  Copyright (c) 2013 Scanplay. All rights reserved.
//

#import <MapKit/MapKit.h>

#define ANNOTATION_REGION_PAD_FACTOR 1.10f

static inline MKMapRect mapRectForCoordinateRegion(MKCoordinateRegion coordinateRegion) {
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

static inline CGFloat radiusInMilesOfMapRect(MKMapRect mapRect) {
    MKMapPoint origin = mapRect.origin;
    MKMapPoint southWestPoint = MKMapPointMake(origin.x,
                                               origin.y - mapRect.size.height);
    MKMapPoint northEastPoint = MKMapPointMake(origin.x + mapRect.size.width,
                                               origin.y);
    
    CLLocationDistance width = MKMetersBetweenMapPoints(origin, northEastPoint);
    CLLocationDistance height = MKMetersBetweenMapPoints(origin, southWestPoint);
    CGFloat diameterMeters = fmin(width, height);
    CGFloat radiusMiles = diameterMeters * 0.5f * CONVERSION_FACTOR_METERS_TO_MILES / ANNOTATION_REGION_PAD_FACTOR;
    return radiusMiles;
}


@interface MKMapView (Zooming)

-(MKMapRect)mapRectToFitAnnotations:(NSArray*)annotations;
-(void)zoomToFitAnnotationsAnimated:(BOOL)isAnimated;
-(void)zoomtofitAnnotationsCenteredOnLocation:(CLLocation*)location animated:(BOOL)animated; 
-(void)zoomToLocation:(CLLocation*)location withMarginInMiles:(CGFloat)miles animated:(BOOL)animated;
-(void)zoomToUserWithMarginInMiles:(CGFloat)miles;

-(MKZoomScale)zoomScale;
@end
