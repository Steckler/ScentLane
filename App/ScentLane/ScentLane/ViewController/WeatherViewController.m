//
//  WeatherViewController.m
//  ScentLane
//
//  Created by Lukas Winkler on 20.10.14.
//  Copyright (c) 2014 Steckler. All rights reserved.
//

#import "WeatherViewController.h"
#import "SWRevealViewController.h"

#define API_KEY @"10a2de28f115d521"

@interface WeatherViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;

@end

float Glatidude= 0;
float Glongitude= 0;

@implementation WeatherViewController

- (void)viewDidLoad
{
    [self.actMiddle startAnimating];
    [super viewDidLoad];
    [self revealSetup];
    _lblLatidude.text=@" ";
    _lblLongitude.text=@" ";
    _lblTemperature.text=@" ";
    _lblWindDirection.text=@" ";
    _lblWindSpeed.text=@" ";
    _lblConditions.text=@" ";
    _lblHumidity.text=@" ";
    _lblAirPressure.text=@" ";
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self getCurrentLocation:@"x"];
    [self getCurrentTemperature:@"x"];
    [self.actMiddle setHidden:true];
}

- (void)revealSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer:revealViewController.panGestureRecognizer];
    }
}

- (void)hideAll
{

}

- (void)displayAll
{
    
}

- (IBAction)getCurrentLocation:(id)sender {
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
    
    float latidude = locationManager.location.coordinate.latitude;
    float longitude =locationManager.location.coordinate.longitude;
    
    Glatidude = latidude;
    Glongitude = longitude;
    
    NSString *strLat = [NSString stringWithFormat:@"%f", latidude];
    NSString *strLong = [NSString stringWithFormat:@"%f", longitude];
    
    _lblLongitude.text=strLong;
    _lblLatidude.text=strLat;
}




#pragma mark - Methods for retrieving weather from Wunderground

- (IBAction)getCurrentTemperature:(id)sender {

    NSString *urlString;
    
    // get URL for current conditions
    urlString = [NSString stringWithFormat:@"http://api.wunderground.com/api/%@/conditions/q/%+f,%+f.json",
                     API_KEY,
                     Glatidude,
                     Glongitude];
    
    
    NSURL *url          = [NSURL URLWithString:urlString];
    
    NSData *weatherData = [NSData dataWithContentsOfURL:url];
    
    // make sure we were able to get some response from the URL; if not
    // maybe your internet connection is not operational, or something
    // like that.
    
    // parse the JSON results
    
    NSError *error;
    id weatherResults = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&error];

    
    // if we've gotten here, that means that we've parsed the JSON feed from Wunderground,
    // so now let's see if we got the expected response
    
    //NSDictionary *response = weatherResults[@"response"];
    NSDictionary *currentObservation = weatherResults[@"current_observation"];
    
    
    
    NSNumber *tempC      = currentObservation[@"temp_c"];
    self.lblTemperature.text = [tempC stringValue];
    
    NSString *windDirection = currentObservation[@"wind_dir"];
    self.lblWindDirection.text = windDirection;
    
    NSNumber *windSpeed = currentObservation[@"wind_kph"];
    self.lblWindSpeed.text = [windSpeed stringValue];
    
    NSString *conditions = currentObservation[@"weather"];
    self.lblConditions.text = conditions;
    
    NSString *humidity = currentObservation[@"relative_humidity"];
    self.lblHumidity.text = humidity;
    
    NSString *airPressure   = currentObservation[@"pressure_mb"];
    self.lblAirPressure.text = airPressure;
    
    NSString *imgAdress = currentObservation[@"icon_url"];
    self.imgWeather.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgAdress]]];
   
}


@end
