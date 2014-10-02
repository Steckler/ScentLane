//
//  MapViewController.h
//  ScentLane
//
//  Created by Lukas Winkler on 18.09.14.
//  Copyright (c) 2014 Steckler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

//@interface MapViewController : UIViewController

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end
