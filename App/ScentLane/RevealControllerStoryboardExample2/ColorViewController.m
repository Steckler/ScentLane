//
//  ColorViewController.m
//  RevealControllerStoryboardExample
//
//  Created by Nick Hodapp on 1/9/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import "ColorViewController.h"
#import "TrailItem.h"

@interface ColorViewController ()
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@property NSMutableArray *trailItems;
@end

@implementation ColorViewController

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
    ColorViewController *item1 = [[ColorViewController alloc] init];
    item1.itemName = @"Buy milk";
    [self.trailItems addObject:item1];
    ColorViewController *item2 = [[ColorViewController alloc] init];
    item2.itemName = @"Buy eggs";
    [self.trailItems addObject:item2];
    ColorViewController *item3 = [[ColorViewController alloc] init];
    item3.itemName = @"Read a book";
    [self.trailItems addObject:item3];
}


#pragma mark state preservation / restoration



@end
