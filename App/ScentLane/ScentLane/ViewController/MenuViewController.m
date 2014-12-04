//
//  MenuViewController.m
//  ScentLane
//
//  Created by Lukas Winkler on 18.09.14.
//  Copyright (c) 2014 Steckler. All rights reserved.
//

#import "MenuViewController.h"
#import "AccountViewController.h"
#import "WeatherViewController.h"
#import "TrailsViewController.h"

@implementation SWUITableViewCell
@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";


    switch ( indexPath.row )
    {
        case 0:
            CellIdentifier = @"title";
            break;
            
        case 1:
            CellIdentifier = @"map";
            break;

        case 2:
            CellIdentifier = @"trail";
            break;
            
        case 3:
            CellIdentifier = @"account";
            break;
            
        case 4:
            CellIdentifier = @"weather";
            break;
    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
 
    return cell;
}

#pragma mark state preservation / restoration
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO save what you need here
    
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO restore what you need here
    
    [super decodeRestorableStateWithCoder:coder];
}

- (void)applicationFinishedRestoringState {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO call whatever function you need to visually restore
}

@end
