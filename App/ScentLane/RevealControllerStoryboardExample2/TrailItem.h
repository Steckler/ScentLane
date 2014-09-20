//
//  NSObject+TrailItem.h
//  ScentLane
//
//  Created by Lukas Winkler on 18.09.14.
//  Copyright (c) 2014 Steckler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (TrailItem)

@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;

@end
