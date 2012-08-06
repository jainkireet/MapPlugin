//
//  ViewController.m
//  MapTest
//
//  Created by LetsGoMo08 on 7/27/12.
//  Copyright (c) 2012 LetsGomo. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#import "ViewController.h"
#import "MyLocation.h"
#import "Waypoint.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize _mapView,waypointsArray;


-(void)setArray:(NSMutableArray*) array{
    waypointsArray = array;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
     
    
    double latitude = 28.458505;
    double longitude = 77.061299;
    NSString *title = @"Current Location";
    NSString *subtitle = @"Letsgomo labs";
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = latitude;
    coordinate.longitude = longitude;
    MyLocation *annotation = [[MyLocation alloc]initWithName:title address:subtitle coordinate:coordinate];
    [_mapView addAnnotation:annotation];
    
    CLLocationCoordinate2D coordinate_next;
    coordinate_next.latitude = latitude;
    coordinate_next.longitude = longitude+0.001;
    MyLocation *annotation_next = [[MyLocation alloc]initWithName:@"Not Known" address:@"next building" coordinate:coordinate_next];
    [_mapView addAnnotation:annotation_next];
    NSString* urlString = [NSString stringWithFormat: @"http://maps.google.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=false", coordinate.latitude, coordinate.longitude,coordinate_next.latitude,coordinate_next.longitude];
    NSURL *url = [NSURL URLWithString:urlString];
    dispatch_async(kBgQueue,^{
        NSData* data = [NSData dataWithContentsOfURL: 
                        url];
        [self performSelectorOnMainThread:@selector(fetchedData:) 
                               withObject:data waitUntilDone:YES];
    });
    
}

- (void)fetchedData:(NSData *)responseData {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:responseData
                          options:kNilOptions 
                          error:&error];
    NSArray* routeArray = [json objectForKey:@"routes"];
    NSDictionary* routeDict = [routeArray objectAtIndex:0];
    NSDictionary* polylineDict = [routeDict objectForKey:@"overview_polyline"];
    NSString *plylineString = [polylineDict objectForKey:@"points"];
    NSMutableArray *pointsArray = [self decodePolyline:plylineString];
    NSLog(@"data: %@", pointsArray);
    [self paintLines:pointsArray];
}

-(void)paintLines:(NSMutableArray *)points{
    CLLocationCoordinate2D *locations = malloc(sizeof(CLLocationCoordinate2D) * points.count);
    int count = 0;
    
    for (int i = 0; i < points.count; i++)
    {
        Waypoint *point = [points objectAtIndex:i];
        CLLocationCoordinate2D pointCoordinate;
        pointCoordinate.latitude = [point getLat];
        pointCoordinate.longitude = [point getLong];
        locations[count] = pointCoordinate; 
        count++;
    }
    
    MKPolyline *routeLine = [MKPolyline polylineWithCoordinates:locations count:points.count];    
    [_mapView addOverlay:routeLine];
    free(locations);
}

- (void)viewDidUnload
{
    [self set_mapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 28.458505;
    zoomLocation.longitude = 77.061299;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, METERS_PER_MILE, METERS_PER_MILE);
    
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];                
    
    [_mapView setRegion:adjustedRegion animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *identifier = @"MyLocation";   
    if ([annotation isKindOfClass:[MyLocation class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        return annotationView;
    }
    
    return nil;    
}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay
{
    MKPolylineView *polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
    polylineView.strokeColor = [UIColor blueColor];
    polylineView.lineWidth = 5.0;
    return polylineView;    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl*)control
{
    NSLog(@"calloutAccessoryControlTapped");
}

- (NSMutableArray *) decodePolyline:(NSString *)encodedPoints {
    int len = [encodedPoints length];
    NSMutableArray *waypoints = [[NSMutableArray alloc] init];
    int index = 0;
    float lat = 0;
    float lng = 0;
    
    while (index < len) {
        char b;
        int shift = 0;
        int result = 0;
        do {
            b = [encodedPoints characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        
        float dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lat += dlat;
        
        shift = 0;
        result = 0;
        do {
            b = [encodedPoints characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        
        float dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lng += dlng;
        
        float finalLat = lat * 1e-5;
        float finalLong = lng * 1e-5;
        
        Waypoint *newPoint = [[Waypoint alloc] init];
        [newPoint setlatlong:finalLat:finalLong];
        [waypoints addObject:newPoint];    }
    return waypoints;
}


@end
