//
//  ViewController.h
//  MapTest
//
//  Created by LetsGoMo08 on 7/27/12.
//  Copyright (c) 2012 LetsGomo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#define METERS_PER_MILE 1609.344

@interface ViewController : UIViewController <MKMapViewDelegate>{
    IBOutlet MKMapView *_mapView;
    NSMutableArray *waypointsArray;
}
@property (retain, nonatomic) NSMutableArray *waypointsArray;
@property (retain, nonatomic) IBOutlet MKMapView *_mapView;

-(void)setArray:(NSMutableArray*) array;

@end
