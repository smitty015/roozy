//
//  LRCoreDataExtensions.h
//  lifecycleRide
//
//  Created by Andy Roth on 1/17/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRUser.h"
#import "LRRide.h"
#import "NSDate-Utilities.h"

#pragma mark -
#pragma mark LRUser

@interface LRUser (CoreDataExtensions)

@property (nonatomic, readonly) int totalMiles;
@property (nonatomic, readonly) int totalIndoorMiles;
@property (nonatomic, readonly) int totalOutdoorMiles;

- (NSArray *) sortedRides;
- (LRRide *) addNewRideWithMiles:(int)miles date:(NSDate *)date isIndoor:(BOOL)isIndoor;

@end

#pragma mark -
#pragma mark LRRide

@interface LRRide (CoreDataExtensions)

// TODO

@end
