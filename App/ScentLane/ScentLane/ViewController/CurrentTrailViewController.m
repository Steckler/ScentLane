//
//  CurrentTrailViewController.m
//  ScentLane
//
//  Created by Lukas Winkler on 03.12.14.
//  Copyright (c) 2014 Steckler. All rights reserved.
//

#import "CurrentTrailViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MapKit/MapKit.h>
#import "MathController.h"
#import "Trail.h"
#import "Location.h"
#import "TrailDetailsViewController.h"


static NSString * const detailSegueName = @"NewTrailDetails";

@interface CurrentTrailViewController () <UIActionSheetDelegate, CLLocationManagerDelegate, MKMapViewDelegate>

@property int seconds;
@property float distance;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) Trail *trail;


@property (nonatomic, weak) IBOutlet UILabel *promptLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *distLabel;
@property (nonatomic, weak) IBOutlet UILabel *paceLabel;
@property (nonatomic, weak) IBOutlet UILabel *nextBadgeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *progressImageView;
@property (nonatomic, weak) IBOutlet UIImageView *nextBadgeImageView;
@property (nonatomic, weak) IBOutlet UIButton *startButton;
@property (nonatomic, weak) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation CurrentTrailViewController

#pragma mark - Lifecycle

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.startButton.hidden = NO;
    self.promptLabel.hidden = NO;
    
    self.timeLabel.text = @"";
    self.timeLabel.hidden = YES;
    self.distLabel.hidden = YES;
    self.paceLabel.hidden = YES;
    self.nextBadgeLabel.hidden = YES;
    self.stopButton.hidden = YES;
    self.nextBadgeImageView.hidden = YES;
    self.progressImageView.hidden = YES;
    self.mapView.hidden = YES;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
}



#pragma mark - IBActions

-(IBAction)startPressed:(id)sender
{
    // hide the start UI
    self.startButton.hidden = YES;
    self.promptLabel.hidden = YES;
    
    // show the running UI
    self.timeLabel.hidden = NO;
    self.distLabel.hidden = NO;
    self.paceLabel.hidden = NO;
    self.stopButton.hidden = NO;
    self.progressImageView.hidden = NO;
    //self.nextBadgeImageView.hidden = NO;
    //self.nextBadgeLabel.hidden = NO;
    self.mapView.hidden = NO;
    
    self.seconds = 0;
    
    // initialize the timer
	self.timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(eachSecond) userInfo:nil repeats:YES];
    
    self.distance = 0;
    self.locations = [NSMutableArray array];
    
    [self startLocationUpdates];
}

- (IBAction)stopPressed:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Save", @"Discard", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}

#pragma mark - Private

- (void)saveTrail
{
    Trail *newTrail = [NSEntityDescription insertNewObjectForEntityForName:@"Trail" inManagedObjectContext:self.managedObjectContext];
    
    newTrail.distance = [NSNumber numberWithFloat:self.distance];
    newTrail.duration = [NSNumber numberWithInt:self.seconds];
    newTrail.timestamp = [NSDate date];
    
    NSMutableArray *locationArray = [NSMutableArray array];
    for (CLLocation *location in self.locations) {
        Location *locationObject = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
        
        locationObject.timestamp = location.timestamp;
        locationObject.latitude = [NSNumber numberWithDouble:location.coordinate.latitude];
        locationObject.longitude = [NSNumber numberWithDouble:location.coordinate.longitude];
        [locationArray addObject:locationObject];
    }
    
    newTrail.locations = [NSOrderedSet orderedSetWithArray:locationArray];
    self.trail = newTrail;
    
    // Save the context.
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void)eachSecond
{
    self.seconds++;
    [self updateProgressImageView];
    //[self maybePlaySound];
    [self updateLabels];
}

- (void)updateProgressImageView
{
    int currentPosition = self.progressImageView.frame.origin.x;
    CGRect newRect = self.progressImageView.frame;
    
    switch (currentPosition) {
        case 20:
            newRect.origin.x = 80;
            break;
        case 80:
            newRect.origin.x = 140;
            break;
        default:
            newRect.origin.x = 20;
            break;
    }
    
    self.progressImageView.frame = newRect;
}

- (void)updateLabels
{
    self.timeLabel.text = [NSString stringWithFormat:@"Time: %@",  [MathController stringifySecondCount:self.seconds usingLongFormat:NO]];
    self.distLabel.text = [NSString stringWithFormat:@"Distance: %@", [MathController stringifyDistance:self.distance]];
    self.paceLabel.text = [NSString stringWithFormat:@"Pace: %@",  [MathController stringifyAvgPaceFromDist:self.distance overTime:self.seconds]];
}

/*
- (void) maybePlaySound
{
    Badge *nextBadge = [[BadgeController defaultController] nextBadgeForDistance:self.distance];
    
    if (self.upcomingBadge
        && ![nextBadge.name isEqualToString:self.upcomingBadge.name]) {
        
        //[self playSuccessSound];
    }
    
    self.upcomingBadge = nextBadge;
    self.nextBadgeImageView.image = [UIImage imageNamed:nextBadge.imageName];
}

- (void)playSuccessSound
{
    NSString *path = [NSString stringWithFormat:@"%@%@", [[NSBundle mainBundle] resourcePath], @"/genericsuccess.wav"];
    SystemSoundID soundID;
    NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(filePath), &soundID);
    AudioServicesPlaySystemSound(soundID);
    
    //also vibrate
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
*/
- (void)startLocationUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.activityType = CLActivityTypeFitness;
    
    // Movement threshold for new events.
    self.locationManager.distanceFilter = 10; // meters
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.locationManager stopUpdatingLocation];
    
    // save
    if (buttonIndex == 0) {
        [self saveTrail];
        //[self performSegueWithIdentifier:detailSegueName sender:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    // discard
    } else if (buttonIndex == 1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    for (CLLocation *newLocation in locations) {
        
        NSDate *eventDate = newLocation.timestamp;
        
        NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
        
        if (abs(howRecent) < 10.0 && newLocation.horizontalAccuracy < 20) {
            
            // update distance
            if (self.locations.count > 0) {
                self.distance += [newLocation distanceFromLocation:self.locations.lastObject];
                
                CLLocationCoordinate2D coords[2];
                coords[0] = ((CLLocation *)self.locations.lastObject).coordinate;
                coords[1] = newLocation.coordinate;

                MKCoordinateRegion region =
                MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 500, 500);
                [self.mapView setRegion:region animated:YES];
                
                [self.mapView addOverlay:[MKPolyline polylineWithCoordinates:coords count:2]];
            }
            
            [self.locations addObject:newLocation];
        }
    }
}

#pragma mark - MKMapViewDelegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolyline *polyLine = (MKPolyline *)overlay;
        MKPolylineRenderer *aRenderer = [[MKPolylineRenderer alloc] initWithPolyline:polyLine];
        aRenderer.strokeColor = [UIColor blueColor];
        aRenderer.lineWidth = 3;
        return aRenderer;
    }
    
    return nil;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:detailSegueName]) {
        [[segue destinationViewController] setTrail:self.trail];
    }
}

@end
