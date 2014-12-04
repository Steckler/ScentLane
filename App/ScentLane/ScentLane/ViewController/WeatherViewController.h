//
//  WeatherViewController.h
//  ScentLane
//
//  Created by Lukas Winkler on 20.10.14.
//  Copyright (c) 2014 Steckler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface WeatherViewController : UIViewController <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet UILabel *lblLongitude;
@property (weak, nonatomic) IBOutlet UILabel *lblLatidude;
@property (weak, nonatomic) IBOutlet UILabel *lblTemperature;
@property (weak, nonatomic) IBOutlet UILabel *lblWindDirection;
@property (weak, nonatomic) IBOutlet UILabel *lblWindSpeed;
@property (weak, nonatomic) IBOutlet UILabel *lblConditions;
@property (weak, nonatomic) IBOutlet UILabel *lblHumidity;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actMiddle;
@property (weak, nonatomic) IBOutlet UIImageView *imgWeather;

@property (weak, nonatomic) IBOutlet UILabel *lblAirPressure;



- (IBAction)getCurrentLocation:(id)sender;

- (IBAction)getCurrentTemperature:(id)sender;



@end
