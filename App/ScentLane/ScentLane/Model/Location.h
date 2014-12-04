//
//  Location.h
//  ScentLane
//
//  Created by Lukas Winkler on 04.12.14.
//  Copyright (c) 2014 Steckler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Trail;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) Trail *trail;

@end
