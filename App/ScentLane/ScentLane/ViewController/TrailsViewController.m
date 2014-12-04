//
//  TrailsViewController.h
//  ScentLane
//
//  Created by Lukas Winkler on 03.12.14.
//  Copyright (c) 2014 Steckler. All rights reserved.
//

#import "TrailsViewController.h"
#import "TrailDetailsViewController.h"
#import "Trail.h"
#import "RunCell.h"
#import "MathController.h"
#import "SWRevealViewController.h"


@interface TrailsViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;

@end

@implementation TrailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self revealSetup];
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


#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.trailArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RunCell *cell = (RunCell *)[tableView dequeueReusableCellWithIdentifier:@"RunCell"];
    Trail *trailObject = [self.trailArray objectAtIndex:indexPath.row];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    cell.dateLabel.text = [formatter stringFromDate:trailObject.timestamp];
    
    cell.distanceLabel.text = [MathController stringifyDistance:trailObject.distance.floatValue];
    
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue destinationViewController] isKindOfClass:[TrailDetailsViewController class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Trail *trail = [self.trailArray objectAtIndex:indexPath.row];
        [(TrailDetailsViewController *)[segue destinationViewController] setTrail:trail];
    }
}

@end
