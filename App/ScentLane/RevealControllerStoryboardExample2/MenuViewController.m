//
//  MenuViewController.m
//  ScentLane
//
//  Created by Lukas Winkler on 18.09.14.
//  Copyright (c) 2014 Steckler. All rights reserved.
//

#import "MenuViewController.h"
#import "AccountViewController.h"
#import "TrailListController.h"

@implementation SWUITableViewCell
@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.4f alpha:1.0f];
    
}

#pragma mark - Table view data source

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
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
            CellIdentifier = @"red";
            break;
            
        case 3:
            CellIdentifier = @"blue";
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
