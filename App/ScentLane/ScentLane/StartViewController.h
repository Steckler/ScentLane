//
//  UIViewController+LoginViewController.h
//  ScentLane
//
//  Created by Lukas Winkler on 22.10.14.
//  Copyright (c) 2014 Steckler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>


@interface StartViewController : UIViewController <FBLoginViewDelegate>

@property (weak, nonatomic) IBOutlet FBLoginView *loginButton;

@end
