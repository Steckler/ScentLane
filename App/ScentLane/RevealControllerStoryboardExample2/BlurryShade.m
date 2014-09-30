//
//  UIImageView+BlurryShade.m
//  ScentLane
//
//  Created by Lukas Winkler on 26.09.14.
//  Copyright (c) 2014 Steckler. All rights reserved.
//

#import "BlurryShade.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImageView (BlurryShade)


- (void)viewDidLoad
{
    self.layer.masksToBounds = true;
    self.layer.cornerRadius = 5;
}

@end
