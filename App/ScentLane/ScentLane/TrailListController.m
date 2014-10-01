//
//  UITableViewController+TrailListController.m
//  ScentLane
//
//  Created by Lukas Winkler on 18.09.14.
//  Copyright (c) 2014 Steckler. All rights reserved.
//

#import "TrailListController.h"
#import "TrailItem.h"

@interface TrailListController ()
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@property NSMutableArray *trailItems;
@end

//@implementation UITableViewController (TrailListController)
@implementation TrailListController

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customSetup];
    //self.trailItems = [[NSMutableArray alloc] init];
    //[self loadInitialData];
}


- (void)customSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer:revealViewController.panGestureRecognizer];
    }
    
}


- (void)loadInitialData {
    TrailListController *item1 = [[TrailListController alloc] init];
    item1.itemName = @"Buy milk";
    [self.trailItems addObject:item1];
    TrailListController *item2 = [[TrailListController alloc] init];
    item2.itemName = @"Buy eggs";
    [self.trailItems addObject:item2];
    TrailListController *item3 = [[TrailListController alloc] init];
    item3.itemName = @"Read a book";
    [self.trailItems addObject:item3];
}


#pragma mark state preservation / restoration



@end
